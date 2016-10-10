select
  --this id is only unique within a given entry_id; may also want to create a globally unique id for this table.
  id::int,
  {{ var('source_key_id_field') }} as entry_id,
  amount,
  description,
  journalentrylinedetail__accountref__value::integer as account_id,
  {% if var('uses_classes') == "true" %}
    nullif(journalentrylinedetail__classref__value::varchar, '')::bigint as class_id,
  {% endif %}
  journalentrylinedetail__postingtype as posting_type
from
  {{ var('base.journal_entries_line') }}