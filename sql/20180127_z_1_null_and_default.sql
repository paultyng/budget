-- +migrate Up
ALTER TABLE ofx_transactions ALTER COLUMN id SET DEFAULT '',
	ALTER COLUMN transaction_type SET DEFAULT '',
	ALTER COLUMN date_posted SET DEFAULT now(),
	ALTER COLUMN date_user SET DEFAULT '0001-12-31 16:07:02-07:52:58 BC',
	ALTER COLUMN date_available SET DEFAULT '0001-12-31 16:07:02-07:52:58 BC',
	ALTER COLUMN amount SET DEFAULT 0,
	ALTER COLUMN fi_tid SET DEFAULT '',
	ALTER COLUMN server_tid SET DEFAULT '',
	ALTER COLUMN check_num SET DEFAULT '',
	ALTER COLUMN ref_num SET DEFAULT '',
	ALTER COLUMN sic SET DEFAULT 0,
	ALTER COLUMN payee_id SET DEFAULT '',
	ALTER COLUMN name SET DEFAULT '',
	ALTER COLUMN extended_name SET DEFAULT '',
	ALTER COLUMN memo SET DEFAULT '',
	ALTER COLUMN inv_401k_source SET DEFAULT '',
	ALTER COLUMN currency SET DEFAULT '',
	ALTER COLUMN original_currency SET DEFAULT '',
	ALTER COLUMN correct_fi_tid SET DEFAULT '',
	ALTER COLUMN correct_action SET DEFAULT '',
	ALTER COLUMN payee_name SET DEFAULT '',
	ALTER COLUMN payee_addr1 SET DEFAULT '',
	ALTER COLUMN payee_addr2 SET DEFAULT '',
	ALTER COLUMN payee_addr3 SET DEFAULT '',
	ALTER COLUMN payee_city SET DEFAULT '',
	ALTER COLUMN payee_state SET DEFAULT '',
	ALTER COLUMN payee_postal_code SET DEFAULT '',
	ALTER COLUMN payee_country SET DEFAULT '',
	ALTER COLUMN payee_phone SET DEFAULT '',
	ALTER COLUMN bank_account_to_bank_id SET DEFAULT '',
	ALTER COLUMN bank_account_to_branch_id SET DEFAULT '',
	ALTER COLUMN bank_account_to_account_id SET DEFAULT '',
	ALTER COLUMN bank_account_to_account_type SET DEFAULT '',
	ALTER COLUMN bank_account_to_account_key SET DEFAULT '',
	ALTER COLUMN credit_card_account_to_account_id SET DEFAULT '',
	ALTER COLUMN credit_card_account_to_account_key SET DEFAULT '',
	ALTER COLUMN account_id SET DEFAULT '',
	ALTER COLUMN recurring_id SET DEFAULT '';

ALTER TABLE ofx_transactions ALTER COLUMN id SET NOT NULL,
	ALTER COLUMN transaction_type SET NOT NULL,
	ALTER COLUMN date_posted SET NOT NULL,
	ALTER COLUMN date_user SET NOT NULL,
	ALTER COLUMN date_available SET NOT NULL,
	ALTER COLUMN amount SET NOT NULL,
	ALTER COLUMN fi_tid SET NOT NULL,
	ALTER COLUMN server_tid SET NOT NULL,
	ALTER COLUMN check_num SET NOT NULL,
	ALTER COLUMN ref_num SET NOT NULL,
	ALTER COLUMN sic SET NOT NULL,
	ALTER COLUMN payee_id SET NOT NULL,
	ALTER COLUMN name SET NOT NULL,
	ALTER COLUMN extended_name SET NOT NULL,
	ALTER COLUMN memo SET NOT NULL,
	ALTER COLUMN inv_401k_source SET NOT NULL,
	ALTER COLUMN currency SET NOT NULL,
	ALTER COLUMN original_currency SET NOT NULL,
	ALTER COLUMN correct_fi_tid SET NOT NULL,
	ALTER COLUMN correct_action SET NOT NULL,
	ALTER COLUMN payee_name SET NOT NULL,
	ALTER COLUMN payee_addr1 SET NOT NULL,
	ALTER COLUMN payee_addr2 SET NOT NULL,
	ALTER COLUMN payee_addr3 SET NOT NULL,
	ALTER COLUMN payee_city SET NOT NULL,
	ALTER COLUMN payee_state SET NOT NULL,
	ALTER COLUMN payee_postal_code SET NOT NULL,
	ALTER COLUMN payee_country SET NOT NULL,
	ALTER COLUMN payee_phone SET NOT NULL,
	ALTER COLUMN bank_account_to_bank_id SET NOT NULL,
	ALTER COLUMN bank_account_to_branch_id SET NOT NULL,
	ALTER COLUMN bank_account_to_account_id SET NOT NULL,
	ALTER COLUMN bank_account_to_account_type SET NOT NULL,
	ALTER COLUMN bank_account_to_account_key SET NOT NULL,
	ALTER COLUMN credit_card_account_to_account_id SET NOT NULL,
	ALTER COLUMN credit_card_account_to_account_key SET NOT NULL,
	ALTER COLUMN account_id SET NOT NULL,
	ALTER COLUMN recurring_id SET NOT NULL;

ALTER TABLE accounts ALTER COLUMN id SET DEFAULT '',
	ALTER COLUMN name SET DEFAULT '',
	ALTER COLUMN account_type SET DEFAULT '',
	ALTER COLUMN request_type SET DEFAULT '',
	ALTER COLUMN bank_org SET DEFAULT '',
	ALTER COLUMN bank_fid SET DEFAULT '',
	ALTER COLUMN bank_url SET DEFAULT '',
	ALTER COLUMN sync SET DEFAULT false;

ALTER TABLE accounts ALTER COLUMN id SET NOT NULL,
	ALTER COLUMN name SET NOT NULL,
	ALTER COLUMN account_type SET NOT NULL,
	ALTER COLUMN request_type SET NOT NULL,
	ALTER COLUMN bank_org SET NOT NULL,
	ALTER COLUMN bank_fid SET NOT NULL,
	ALTER COLUMN bank_url SET NOT NULL,
	ALTER COLUMN sync SET NOT NULL;

-- +migrate Down
ALTER TABLE ofx_transactions ALTER COLUMN id DROP DEFAULT,
	ALTER COLUMN transaction_type DROP DEFAULT,
	ALTER COLUMN date_posted DROP DEFAULT,
	ALTER COLUMN date_user DROP DEFAULT,
	ALTER COLUMN date_available DROP DEFAULT,
	ALTER COLUMN amount DROP DEFAULT,
	ALTER COLUMN fi_tid DROP DEFAULT,
	ALTER COLUMN server_tid DROP DEFAULT,
	ALTER COLUMN check_num DROP DEFAULT,
	ALTER COLUMN ref_num DROP DEFAULT,
	ALTER COLUMN sic DROP DEFAULT,
	ALTER COLUMN payee_id DROP DEFAULT,
	ALTER COLUMN name DROP DEFAULT,
	ALTER COLUMN extended_name DROP DEFAULT,
	ALTER COLUMN memo DROP DEFAULT,
	ALTER COLUMN inv_401k_source DROP DEFAULT,
	ALTER COLUMN currency DROP DEFAULT,
	ALTER COLUMN original_currency DROP DEFAULT,
	ALTER COLUMN correct_fi_tid DROP DEFAULT,
	ALTER COLUMN correct_action DROP DEFAULT,
	ALTER COLUMN payee_name DROP DEFAULT,
	ALTER COLUMN payee_addr1 DROP DEFAULT,
	ALTER COLUMN payee_addr2 DROP DEFAULT,
	ALTER COLUMN payee_addr3 DROP DEFAULT,
	ALTER COLUMN payee_city DROP DEFAULT,
	ALTER COLUMN payee_state DROP DEFAULT,
	ALTER COLUMN payee_postal_code DROP DEFAULT,
	ALTER COLUMN payee_country DROP DEFAULT,
	ALTER COLUMN payee_phone DROP DEFAULT,
	ALTER COLUMN bank_account_to_bank_id DROP DEFAULT,
	ALTER COLUMN bank_account_to_branch_id DROP DEFAULT,
	ALTER COLUMN bank_account_to_account_id DROP DEFAULT,
	ALTER COLUMN bank_account_to_account_type DROP DEFAULT,
	ALTER COLUMN bank_account_to_account_key DROP DEFAULT,
	ALTER COLUMN credit_card_account_to_account_id DROP DEFAULT,
	ALTER COLUMN credit_card_account_to_account_key DROP DEFAULT,
	ALTER COLUMN account_id DROP DEFAULT,
	ALTER COLUMN recurring_id DROP DEFAULT;

ALTER TABLE ofx_transactions ALTER COLUMN transaction_type DROP NOT NULL,
	ALTER COLUMN date_posted DROP NOT NULL,
	ALTER COLUMN date_user DROP NOT NULL,
	ALTER COLUMN date_available DROP NOT NULL,
	ALTER COLUMN amount DROP NOT NULL,
	ALTER COLUMN fi_tid DROP NOT NULL,
	ALTER COLUMN server_tid DROP NOT NULL,
	ALTER COLUMN check_num DROP NOT NULL,
	ALTER COLUMN ref_num DROP NOT NULL,
	ALTER COLUMN sic DROP NOT NULL,
	ALTER COLUMN payee_id DROP NOT NULL,
	ALTER COLUMN name DROP NOT NULL,
	ALTER COLUMN extended_name DROP NOT NULL,
	ALTER COLUMN memo DROP NOT NULL,
	ALTER COLUMN inv_401k_source DROP NOT NULL,
	ALTER COLUMN currency DROP NOT NULL,
	ALTER COLUMN original_currency DROP NOT NULL,
	ALTER COLUMN correct_fi_tid DROP NOT NULL,
	ALTER COLUMN correct_action DROP NOT NULL,
	ALTER COLUMN payee_name DROP NOT NULL,
	ALTER COLUMN payee_addr1 DROP NOT NULL,
	ALTER COLUMN payee_addr2 DROP NOT NULL,
	ALTER COLUMN payee_addr3 DROP NOT NULL,
	ALTER COLUMN payee_city DROP NOT NULL,
	ALTER COLUMN payee_state DROP NOT NULL,
	ALTER COLUMN payee_postal_code DROP NOT NULL,
	ALTER COLUMN payee_country DROP NOT NULL,
	ALTER COLUMN payee_phone DROP NOT NULL,
	ALTER COLUMN bank_account_to_bank_id DROP NOT NULL,
	ALTER COLUMN bank_account_to_branch_id DROP NOT NULL,
	ALTER COLUMN bank_account_to_account_id DROP NOT NULL,
	ALTER COLUMN bank_account_to_account_type DROP NOT NULL,
	ALTER COLUMN bank_account_to_account_key DROP NOT NULL,
	ALTER COLUMN credit_card_account_to_account_id DROP NOT NULL,
	ALTER COLUMN credit_card_account_to_account_key DROP NOT NULL,
	ALTER COLUMN account_id DROP NOT NULL,
	ALTER COLUMN recurring_id DROP NOT NULL;

ALTER TABLE accounts ALTER COLUMN id DROP DEFAULT,
	ALTER COLUMN name DROP DEFAULT,
	ALTER COLUMN account_type DROP DEFAULT,
	ALTER COLUMN request_type DROP DEFAULT,
	ALTER COLUMN bank_org DROP DEFAULT,
	ALTER COLUMN bank_fid DROP DEFAULT,
	ALTER COLUMN bank_url DROP DEFAULT,
	ALTER COLUMN sync DROP DEFAULT;

ALTER TABLE accounts ALTER COLUMN name DROP NOT NULL,
	ALTER COLUMN account_type DROP NOT NULL,
	ALTER COLUMN request_type DROP NOT NULL,
	ALTER COLUMN bank_org DROP NOT NULL,
	ALTER COLUMN bank_fid DROP NOT NULL,
	ALTER COLUMN bank_url DROP NOT NULL,
	ALTER COLUMN sync DROP NOT NULL;
