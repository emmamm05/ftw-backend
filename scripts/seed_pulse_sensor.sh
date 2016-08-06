
#!/bin/bash
END=100
for i in $(seq 1 $END); do
	curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -H "Postman-Token: b4b8b361-ab6d-b232-124a-7e007cb2d49e" -d '{
	    "hits":60,
	    "wristband_uuid":"b71242c2-e2a4-439f-b208-f7c07b888a96",
	    "wristband_timestamp":"12312"
	}' "http://127.0.0.1:3000/event_pulse_sensors.json";
done