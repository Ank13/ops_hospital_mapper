# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130710164648) do

  create_table "complications", :force => true do |t|
    t.integer  "provider_id"
    t.integer  "N_P_D_S_T_C"
    t.float    "R_D_S_T_C"
    t.float    "L_E_D_S_T_C"
    t.float    "H_E_D_S_T_C"
    t.integer  "N_P_C_L"
    t.float    "R_C_L"
    t.float    "L_E_C_L"
    t.float    "H_E_C_L"
    t.integer  "N_P_B_C"
    t.float    "R_B_C"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "complications", ["provider_id"], :name => "index_complications_on_provider_id"

  create_table "hospitals", :id => false, :force => true do |t|
    t.integer  "provider_id"
    t.string   "provider_name"
    t.string   "provider_street_address"
    t.string   "provider_city"
    t.string   "provider_state"
    t.integer  "provider_zip_code"
    t.string   "hrr"
    t.integer  "total_discharges"
    t.integer  "count_drgs"
    t.float    "average_covered_charges"
    t.float    "average_total_payments"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "total_cost_index"
  end

  add_index "hospitals", ["provider_id"], :name => "index_hospitals_on_provider_id"

  create_table "hospitals_procedures", :force => true do |t|
    t.integer "drg_id"
    t.string  "drg_def"
    t.integer "provider_id"
    t.string  "provider_name"
    t.integer "total_discharges"
    t.float   "avg_covered_charges"
    t.float   "avg_total_payments"
    t.integer "cost_index"
  end

  add_index "hospitals_procedures", ["drg_id"], :name => "index_hospitals_procedures_on_drg_id"
  add_index "hospitals_procedures", ["provider_id"], :name => "index_hospitals_procedures_on_provider_id"

  create_table "outcomes", :force => true do |t|
    t.integer  "provider_id"
    t.float    "mr_h_a"
    t.float    "lme_mr_h_a"
    t.float    "ume_mr_h_a"
    t.integer  "num_p_mr_ha"
    t.float    "mr_hf"
    t.float    "lme_mr_hf"
    t.float    "ume_mr_hf"
    t.integer  "num_p_mr_hf"
    t.float    "mr_p"
    t.float    "lme_mr_pn"
    t.float    "ume_mr_pn"
    t.integer  "num_p_mr_pn"
    t.float    "readm_ha"
    t.float    "lreadma_ha"
    t.float    "ureadma_ha"
    t.integer  "num_p_readm_ha"
    t.float    "readma_hf"
    t.float    "lreadmae_hf"
    t.float    "ureadmae_hf"
    t.integer  "num_p_readma_hf"
    t.float    "readma_pn"
    t.float    "lreadma_pn"
    t.float    "ureadma_pn"
    t.integer  "num_p_readma_pn"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "outcomes", ["provider_id"], :name => "index_outcomes_on_provider_id"

  create_table "patient_surveys", :force => true do |t|
    t.integer  "provider_id"
    t.float    "doc_comm_bad"
    t.float    "doc_com_ok"
    t.float    "doc_com_good"
    t.float    "help_timingbad"
    t.float    "help_timing_ok"
    t.float    "help_timing_good"
    t.float    "pain_ctrl_bad"
    t.float    "pain_ctrl_ok"
    t.float    "pain_ctrl_good"
    t.float    "quiet_no"
    t.float    "quiet_usu"
    t.float    "quiet_always"
    t.float    "recovery_info_yes"
    t.float    "recovery_info_no"
    t.float    "rating_low"
    t.float    "rating_mid"
    t.float    "rating_high"
    t.float    "recommend_no"
    t.float    "recommend_ok"
    t.float    "recommend_y"
    t.string   "num_surveys"
    t.float    "survey_response_rate"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "patient_surveys", ["provider_id"], :name => "index_patient_surveys_on_provider_id"

  create_table "procedures", :id => false, :force => true do |t|
    t.integer  "drg_id"
    t.string   "drg_def"
    t.integer  "total_discharges"
    t.float    "avg_covered_charges"
    t.float    "avg_total_payments"
    t.integer  "natl_total_discharges"
    t.float    "natl_avg_covered_charges"
    t.float    "natl_avg_total_payments"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.text     "description",              :default => ""
    t.string   "clinical_category",        :default => ""
  end

  add_index "procedures", ["drg_id"], :name => "index_procedures_on_drg_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "states_procedures", :force => true do |t|
    t.integer  "drg_id"
    t.string   "provider_state"
    t.integer  "total_discharges"
    t.float    "avg_covered_charges"
    t.float    "avg_total_payments"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "states_procedures", ["drg_id"], :name => "index_states_procedures_on_drg_id"

end
