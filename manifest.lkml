project_name: "certm_demo_6"

constant: CONNECTION_NAME {
  value: "midt_dev_connect_4905"
  export: override_required
}

#Project ID
constant: GCP_PROJECT {
  value: "sab-dev-proj-dev-dw-4905"
  export: override_required
}

#Dataset Name
constant: REPORTING_DATASET {
  value: "MIDT_CURATED"
  export: override_required
}
