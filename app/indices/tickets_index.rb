ThinkingSphinx::Index.define :ticket, with: :active_record do
  #fields
  indexes subject, sortable: true
  indexes body
  indexes random_id

  #attributes
  has email, created_at, updated_at
end