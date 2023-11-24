## Recursive Separation of Responsibilities

A role leader might delegate system components to colleagues, who report high-level information back up to the leaders.

Several roles that could be delegated:

- Incident Command
	- Hold the high-level state about the incident, structure the incident response task force, assigning responsibilities according to need and priority.
	- Hold all positions that they have not delegated.
	- Keep a living incident document.
- Operational Work
	- Work with the commander to respond to the incident by applying operational tools.
- Communication
	- The public face of the incident response task force.
- Planning
	- Deal with longer-term issues, such as filing bugs, ordering dinner, arranging handoffs, and tracking how the system has diverged from the norm, so that it can be reverted later.

## Tracking Outages

Build a tracking system where Multiple escalating notifications ("alerts") can be combined into a single entity ("incident") with free-form tags like `cause:network`, `bug:1234` and `bogus`.