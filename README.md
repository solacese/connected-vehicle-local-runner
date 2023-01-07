# Connected Vehicles Local Runner

This is a helper project to run the connected vehicles demo on your local machine.

The whole demo consists of 4 parts:

1. [Solace PubSub+ Event Broker](https://solace.com/products/event-broker/)
1. A [data-generator](https://github.com/solacese/connected-vehicle-data-generator) to simulate connected vehicles by pushing vehicle information in the MQTT protocol
1. A [web frontend](https://github.com/solacese/connected-vehicle-web) to show the moving vehicles on google map, and the users could filter those vehicles by route number, vehicle type, and status, etc, or by geo locations
1. Finally, the [geo-filtering](https://github.com/solacese/geo-filtering) microservice calculates rectangles to cover the shapes the users drew on google map

```text
                            +-----------------+                     
                            |       Web       |                     
                            +-----------------+                     
                                     |                              
                              +------o------+                       
                              |    Solace   |      +---------------+
                              |     PS+     o------| Geo Filtering |
                              |    Broker   |      +---------------+
                              +------o------+                       
                                     |                              
                                +---------+                         
                                |  Data   |                         
                                |Generator|                         
                                +---------+                         
                                                            
```

## Steps

### 1. Clone all repos

```bash
mkdir demo
cd demo
git clone https://github.com/solacese/connected-vehicle-local-runner
git clone https://github.com/solacese/connected-vehicle-web
git clone https://github.com/solacese/connected-vehicle-data-generator
git clone https://github.com/solacese/geo-filtering
```

### 2. Build docker images

Please build docker images of the [data-generator](https://github.com/solacese/connected-vehicle-data-generator) and [geo-filtering](https://github.com/solacese/geo-filtering) by following the `Build Docker Image` section of the README. Then you should have image `ichen/geo-filtering:0.0.1` and `ichen/data-generator:0.0.1` in your machine.

```bash
> docker image ls
REPOSITORY                      TAG                     IMAGE ID       CREATED         SIZE
ichen/geo-filtering             0.0.1                   81981f3a3b08   2 hours ago     228MB
ichen/data-generator            0.0.1                   3ef88bcc739f   6 hours ago     196MB
node                            16.17.0-bullseye-slim   8e4ba45a6265   3 months ago    191MB
openjdk                         11-jre-slim-buster      cc0d7e216e18   5 months ago    216MB

```

### 3. Run the demo

Run `docker-compose up` to create and start all 4 parts, wait for the `Press Ctrl+C to exit` message to show up, then access [http://localhost:9090/](http://localhost:9090/) to enjoy the demo.

```bash
cd connected-vehicle-local-runner/
docker-compose up
Creating network "connected-vehicle-local-runner_default" with the default driver
Creating connected-vehicle-local-runner_solace_1 ... done
Creating connected-vehicle-local-runner_web_1            ... done
Creating connected-vehicle-local-runner_data-generator_1 ... done
Creating connected-vehicle-local-runner_geo-filtering_1  ... done
...
...
...
data-generator_1  | 1/7/2023, 8:37:21 AM: Connection refused: Server unavailable
geo-filtering_1   | 2023-01-07 08:37:21: Solace service is ready!
geo-filtering_1   | 2023-01-07 08:37:21: Enable subscription management capability of the client successfully
data-generator_1  | Connected, ready to send mqtt messages ...
data-generator_1  | Start all 63 vehicles
data-generator_1  | Press Ctrl+C to exit ...
geo-filtering_1   | 08:37:22.527 [main] INFO  c.solace.demo.App - Start to connect to host solace:55555, with user default@default
geo-filtering_1   | 08:37:22.659 [main] INFO  c.solace.demo.App - Connected. Awaiting message...
geo-filtering_1   | Press Ctrl+C to exit
```
