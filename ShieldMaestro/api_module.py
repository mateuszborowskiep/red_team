import datetime
import json
from fastapi import FastAPI, HTTPException
from google.cloud import tasks_v2
from google.protobuf import timestamp_pb2
from pydantic import BaseModel

app = FastAPI()

class ScanRequest(BaseModel):
    repo_url: str
    # Add any other fields you might require

@app.post("/scan")
async def create_scan_task(scan_request: ScanRequest):
    try:
        # Enqueue the scanning task with the data from the request
        enqueue_task(scan_request.dict())
        return {"message": "Scan task enqueued successfully", "data": scan_request}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    
def enqueue_task(task_data):
    # Code to enqueue the task
    # This might involve interacting with Google Cloud Tasks API or another task queue system
    pass

def create_task(project, queue, location, url, payload=None, in_seconds=None):
    client = tasks_v2.CloudTasksClient()
    parent = client.queue_path(project, location, queue)
    task = {
        "http_request": {
            "http_method": tasks_v2.HttpMethod.POST,
            "url": url,
            "headers": {"Content-type": "application/json"}
        }
    }

    if payload:
        converted_payload = json.dumps(payload).encode()
        task['http_request']['body'] = converted_payload

    if in_seconds:
        d = datetime.datetime.utcnow() + datetime.timedelta(seconds=in_seconds)
        timestamp = timestamp_pb2.Timestamp()
        timestamp.FromDatetime(d)
        task['schedule_time'] = timestamp

    response = client.create_task(request={"parent": parent, "task": task})
    return response

@app.post("/enqueue_task/")
async def enqueue_task(payload: dict):
    project = 'your-gcp-project'
    queue = 'your-queue'
    location = 'your-location'
    url = 'https://your-kubernetes-backend-service-url'

    try:
        task_response = create_task(project, queue, location, url, payload)
        return {"task_id": task_response.name}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
