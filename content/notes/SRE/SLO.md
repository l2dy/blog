## Purpose

[[notes/SRE/Managing Service Risk|Managing Service Risk]]

SLOs should be a major driver in prioritizing work for SREs and product developers, because they reflect what users care about. A poorly thought-out SLO can result in wasted work if a team uses heroic efforts to meet an overly aggressive SLO, or a bad product if the SLO is too lax.

## Process

1. Identify the relevant [[notes/SRE/Service Level Indicator|SLIs]].
2. Choose and publish SLOs and SLAs.
3. Keep tracking and revise as needed.

Choosing and publishing SLOs to users sets expectations about how a service will perform. Without an explicit SLO, users often develop their own beliefs about desired performance which may lead to both over-reliance (users incorrectly believe that a service will be more available than it actually is) and under-reliance (prospective users believe a system is flakier and less reliable than it actually is).

Start by thinking about what your users care about, not what you can measure. If you start with what's easy to measure, you'll end up with less useful SLOs. Sometimes, working from desired objectives backward to specific indicators works better than choosing indicators and then coming up with targets.

SLOs should specify how they're measured and the conditions under which they're valid.

## Choosing Targets

Here are several rules to follow when choosing your SLO targets:

### Don't pick a target based on current performance

While understanding the merits and limits of a system is essential, adopting values without reflection may lock you into supporting a system that requires heroic efforts to meet its targets, and that cannot be improved without significant redesign.

### Keep it simple

Complicated aggregations can obscure changes to system performance, and are also harder to reason about.

### Avoid absolutes

No "infinite" scale or "always" available.

### Have as few SLOs as possible

Choose just enough SLOs to provide good coverage of your system's attributes.

### Perfection can wait

You can always refine SLO definitions and targets over time as you learn about a system's behavior. It's better to start with a loose target that you tighten than to choose an overly strict target.

## Managing Expectation

Publishing SLOs set expectations for system behavior. Users often want to know what they can expect from a service in order to understand whether it's appropriate for their use case. There are some tatics you could follow.

### Keep a safety margin

Use a tighter internal SLO than the SLO advertised to users to give yourself room to respond to chronic problems before they become visible externally. A buffer allows you to accommodate re-implementations that trade performance for other attributes, such as cost or ease of maintenance.

### Don't overachieve

Users build on the reality of what you offer, rather than what yo say you'll supply, particularly for infra services.

You can avoid over-dependence by deliberately taking the system offline occasionally, throttling some requests, or designing the system so that it isn't faster under light loads.

## SLA

SRE's role is to help business and legal teams understand the likelihood and difficulty of meeting the SLOs contained in the SLA (Service Level Agreement).

It is wise to be conservative in what you advertise to users.