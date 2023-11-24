With risk conceptualized as a (nonlinear) continuum, we need to determine where to place individual services on the continuum.

We give **equal importance** to

1. Figure out how to engineer great reliability into our systems.
2. Identify the appropriate level of tolerance for the services we run.

For consumer services, product owners are often the product teams (product managers). We often need to do cost/benefit analysis (e.g. reliability vs. revenue) when planning changes.

The cost is not only from compute resources. It also includes the opportunity cost, which is the cost of engineering resources spent to diminish risk that could have been devoted to market opportunity (e.g. features for end users).

For infrastructure services, they have multiple clients, often with varying needs. The key strategy is to deliver services with explicitly delineated levels of service, so that the client can make the right risk and cost-tradeoffs when building their systems.

### Risk Target

Upon setting an availability target, the goal is to explicitly align the risk taken with the risk the business is willing to bear, i.e. make a service reliable enough, but no **more** reliable than it needs to be. See [[notes/SRE/SLO#Choosing Targets|Choosing SLO Targets]] for details.

The target is often set quarterly and tracked weekly or daily. We might set an external quarterly availability target of 99.9%, and back this target with a stronger internal availability target and a contract that stipulates penalties if we fail to deliver to the external target.