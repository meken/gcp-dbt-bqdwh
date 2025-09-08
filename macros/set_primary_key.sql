{% macro set_primary_key(table_name, column_name) %}

  {% if execute %}
    {% set query %}
      ALTER TABLE {{ table_name }} DROP PRIMARY KEY IF EXISTS, ADD PRIMARY KEY ({{ column_name }}) NOT ENFORCED
    {% endset %}
    {% do run_query(query) %}
  {% endif %}

{% endmacro %}
