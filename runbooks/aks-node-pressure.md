# Runbook: AKS Node Pressure

## Trigger

Use this runbook when pods remain Pending, nodes report MemoryPressure/DiskPressure, or cluster autoscaler cannot add capacity.

## Triage

1. Inspect node conditions with `kubectl describe node <node>`.
2. Review pending pods and scheduling events.
3. Confirm requests/limits are realistic.
4. Check autoscaler events and Azure activity logs.
5. Determine whether the issue is workload growth, quota, subnet IP exhaustion, or node failure.

## Recovery

- Drain unhealthy nodes when safe.
- Increase node-pool maximums only after validating quota and subnet capacity.
- Reduce excessive workload requests where supported by evidence.
- Scale critical services first and defer non-critical batch workloads.

## Follow-up

Capture impact, time to detect, time to mitigate, contributing factors, and a permanent corrective action.
