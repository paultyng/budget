package storers

import (
	"database/sql"

	"darlinggo.co/pan"

	"github.com/apex/log"
	"github.com/carvers/budget"
	_ "github.com/lib/pq"
)

type postgres struct {
	db  *sql.DB
	log *log.Logger
}

func NewPostgres(db *sql.DB, l *log.Logger) postgres {
	return postgres{db: db, log: l}
}

func importTransactionsSQL(t []budget.Transaction) *pan.Query {
	pannable := make([]pan.SQLTableNamer, 0, len(t))
	for _, txn := range t {
		pannable = append(pannable, txn)
	}
	q := pan.Insert(pannable...)
	q.Expression("ON CONFLICT (")
	q.Expression(pan.Column(t[0], "Source") + ",")
	q.Expression(pan.Column(t[0], "SourceAccountID") + ",")
	q.Expression(pan.Column(t[0], "SourceAccountType") + ",")
	q.Expression(pan.Column(t[0], "FiTID") + " )")
	q.Expression("DO NOTHING")
	return q.Flush(" ")
}

func (p postgres) ImportTransactions(t []budget.Transaction) error {
	query := importTransactionsSQL(t)
	queryStr, err := query.PostgreSQLString()
	if err != nil {
		return err
	}
	p.log.WithField("query", queryStr).Debug("Importing transactions")
	_, err = p.db.Exec(queryStr, query.Args()...)
	return err
}

func listTransactionsSQL(f budget.TransactionFilters) *pan.Query {
	var t budget.Transaction
	q := pan.New("SELECT " + pan.Columns(t).String() + " FROM " + pan.Table(t))
	if len(f.SourceAccountIDs) > 0 {
		q.Where()
		iface := make([]interface{}, 0, len(f.SourceAccountIDs))
		for _, id := range f.SourceAccountIDs {
			iface = append(iface, id)
		}
		q.In(t, "SourceAccountID", iface...)
	}
	if len(f.TransactionTypes) > 0 {
		q.Where()
		iface := make([]interface{}, 0, len(f.TransactionTypes))
		for _, typ := range f.TransactionTypes {
			iface = append(iface, typ)
		}
		q.In(t, "TransactionType", iface...)
	}
	if f.DatePostedBefore != nil {
		q.Where()
		q.Comparison(t, "DatePosted", "<", *f.DatePostedBefore)
	}
	if f.DatePostedAfter != nil {
		q.Where()
		q.Comparison(t, "DatePosted", ">", *f.DatePostedAfter)
	}
	if f.Amount != nil {
		q.Where()
		q.Comparison(t, "Amount", "=", *f.Amount)
	}
	if f.AmountGreaterThan != nil {
		q.Where()
		q.Comparison(t, "Amount", ">", *f.AmountGreaterThan)
	}
	if f.AmountLessThan != nil {
		q.Where()
		q.Comparison(t, "Amount", "<", *f.AmountLessThan)
	}
	if f.CheckNum != nil {
		q.Where()
		q.Comparison(t, "CheckNum", "=", *f.CheckNum)
	}
	if f.RefNum != nil {
		q.Where()
		q.Comparison(t, "RefNum", "=", *f.RefNum)
	}
	if f.Name != nil {
		q.Where()
		q.Comparison(t, "Name", "=", *f.Name)
	}
	q.Flush(" AND ")
	return q
}

func (p postgres) ListTransactions(f budget.TransactionFilters) ([]budget.Transaction, error) {
	query := listTransactionsSQL(f)
	queryStr, err := query.PostgreSQLString()
	if err != nil {
		return nil, err
	}
	p.log.WithField("query", queryStr).Debug("Listing transactions")
	rows, err := p.db.Query(queryStr, query.Args()...)
	if err != nil {
		return nil, err
	}
	var transactions []budget.Transaction
	for rows.Next() {
		var t budget.Transaction
		err = pan.Unmarshal(rows, &t)
		if err != nil {
			return transactions, err
		}
		transactions = append(transactions, t)
	}
	if err = rows.Err(); err != nil {
		return transactions, err
	}
	return transactions, nil
}

func (p postgres) UpdateTransaction(id string, change budget.TransactionChange) error {
	return nil
}

func createAccountSQL(account budget.Account) *pan.Query {
	return pan.Insert(account)
}

func (p postgres) CreateAccount(account budget.Account) error {
	query := createAccountSQL(account)
	queryStr, err := query.PostgreSQLString()
	if err != nil {
		return err
	}
	p.log.WithField("query", queryStr).Debug("Creating account")
	_, err = p.db.Exec(queryStr, query.Args()...)
	return err
}

func getAccountSQL(id string) *pan.Query {
	var account budget.Account
	q := pan.New("SELECT " + pan.Columns(account).String() + " FROM " + pan.Table(account))
	q.Where()
	q.Comparison(account, "ID", "=", id)
	return q.Flush(" ")
}

func (p postgres) GetAccount(id string) (budget.Account, error) {
	query := getAccountSQL(id)
	queryStr, err := query.PostgreSQLString()
	if err != nil {
		return budget.Account{}, err
	}
	rows, err := p.db.Query(queryStr, query.Args()...)
	if err != nil {
		return budget.Account{}, err
	}
	var account budget.Account
	for rows.Next() {
		err = pan.Unmarshal(rows, &account)
		if err != nil {
			return account, err
		}
	}
	if err = rows.Err(); err != nil {
		return account, err
	}
	if account.ID == "" {
		return account, budget.ErrAccountNotFound
	}
	return account, nil
}

func updateAccountSQL(id string, change budget.AccountChange) *pan.Query {
	var account budget.Account
	q := pan.New("UPDATE " + pan.Table(account) + " SET ")
	if change.Name != nil {
		q.Comparison(account, "Name", "=", *change.Name)
	}
	if change.AccountType != nil {
		q.Comparison(account, "AccountType", "=", *change.AccountType)
	}
	if change.RequestType != nil {
		q.Comparison(account, "RequestType", "=", *change.RequestType)
	}
	if change.BankORG != nil {
		q.Comparison(account, "BankORG", "=", *change.BankORG)
	}
	if change.BankFID != nil {
		q.Comparison(account, "BankFID", "=", *change.BankFID)
	}
	if change.BankURL != nil {
		q.Comparison(account, "BankURL", "=", *change.BankURL)
	}
	q.Flush(", ")
	q.Where()
	q.Comparison(account, "ID", "=", id)
	return q.Flush(" ")
}

func (p postgres) UpdateAccount(id string, change budget.AccountChange) error {
	if change.IsEmpty() {
		return nil
	}
	query := updateAccountSQL(id, change)
	queryStr, err := query.PostgreSQLString()
	if err != nil {
		return err
	}
	p.log.WithField("query", queryStr).WithField("id", id).Debug("updating account")
	_, err = p.db.Exec(queryStr, query.Args()...)
	return err
}

func deleteAccountSQL(id string) *pan.Query {
	var account budget.Account
	q := pan.New("DELETE FROM " + pan.Table(account))
	q.Where()
	q.Comparison(account, "ID", "=", id)
	return q.Flush(" ")
}

func (p postgres) DeleteAccount(id string) error {
	query := deleteAccountSQL(id)
	queryStr, err := query.PostgreSQLString()
	if err != nil {
		return err
	}
	p.log.WithField("query", queryStr).WithField("id", id).Debug("deleting account")
	_, err = p.db.Exec(queryStr, query.Args()...)
	return err
}

func listAccountsSQL() *pan.Query {
	var account budget.Account
	q := pan.New("SELECT " + pan.Columns(account).String() + " FROM " + pan.Table(account))
	q.OrderByDesc(pan.Column(account, "Name"))
	return q.Flush(" ")
}

func (p postgres) ListAccounts() ([]budget.Account, error) {
	query := listAccountsSQL()
	queryStr, err := query.PostgreSQLString()
	if err != nil {
		return nil, err
	}
	p.log.WithField("query", queryStr).Debug("listing account")
	rows, err := p.db.Query(queryStr, query.Args()...)
	if err != nil {
		return nil, err
	}
	var accts []budget.Account
	for rows.Next() {
		var account budget.Account
		err = pan.Unmarshal(rows, &account)
		if err != nil {
			return accts, err
		}
		accts = append(accts, account)
	}
	if err = rows.Err(); err != nil {
		return nil, err
	}
	return accts, nil
}