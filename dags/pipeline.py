import os

from datetime import datetime

from airflow import models
from airflow.operators.empty import EmptyOperator

from airflow.providers.dbt.cloud.operators.dbt import DbtCloudRunJobOperator


DAG_ID = "dbt-pipeline"

JOB_ID = os.getenv("JOB_ID")

with models.DAG(
    DAG_ID,
    schedule_interval="@daily", 
    start_date=datetime(2025, 1, 1),
    catchup=False,
    default_args={
        "retries": 1
    },
    retries=1,
    tags=["dbt"],
) as dag:

    prep_landing_bucket_op = EmptyOperator(task_id="sources_to_landing")

    dbt_invocation_op = DbtCloudRunJobOperator(
        task_id="trigger_dbt_cloud_job_run",
        job_id=os.environ.get("JOB_ID"),
        check_interval=10,
        timeout=300
    )

    inference_op = EmptyOperator(task_id="model_inferencing")

prep_landing_bucket_op >> dbt_invocation_op >> inference_op