import ballerina/task;
import ballerina/io;
import ballerina/lang.runtime;
import ballerina/time;

configurable int interval = ?;
configurable int runCount = ?;
decimal timeInterval = <decimal>interval;

class Job {

    *task:Job;
    int i = 1;
    public function execute() {
        error? runHealthCheckResult = runHealthCheck();
        if (runHealthCheckResult is error) {
            io:println("Failed to execute the health check run");
        }
    }

    isolated function init(int i) {
        self.i = i;
    }
}

public function main() returns error? {
    time:Utc currentUtc = time:utcNow();

    time:Utc newTime = time:utcAddSeconds(currentUtc, 3);

    time:Civil time = time:utcToCivil(newTime);

    task:JobId id = check task:scheduleJobRecurByFrequency(new Job(0), timeInterval, runCount, startTime = time);

    runtime:sleep(400);
}
