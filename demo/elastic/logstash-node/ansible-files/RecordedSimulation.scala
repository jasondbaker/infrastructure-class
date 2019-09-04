package webapp

import scala.concurrent.duration._

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import io.gatling.jdbc.Predef._

class RecordedSimulation extends Simulation {

        val endpoint = System.getProperty("endpoint")

        val httpProtocol = http
                .baseUrl(endpoint)
                .inferHtmlResources()
                .acceptHeader("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
                .acceptEncodingHeader("gzip, deflate")
                .acceptLanguageHeader("en-US,en;q=0.5")
                .userAgentHeader("Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0) Gecko/20100101 Firefox/68.0")

        val headers_0 = Map("Upgrade-Insecure-Requests" -> "1")

        val headers_1 = Map("Accept" -> "image/webp,*/*")



        val scn = scenario("RecordedSimulation")
                .exec(http("request_0")
                        .get("/")
                        .headers(headers_0)
                        .resources(http("request_1")
                        .get("/Suri")
                        .headers(headers_1)))
                .pause(1, 3)
                .exec(http("request_2")
                        .get("/Mark")
                        .headers(headers_0))
                .pause(1, 3)
                .exec(http("request_3")
                        .get("/Alicia")
                        .headers(headers_0))
                .pause(1, 3)
                .exec(http("request_4")
                        .get("/Toni")
                        .headers(headers_0))
                .pause(1, 3)
                .exec(http("request_5")
                        .get("/Roberto")
                        .headers(headers_0))
                .pause(1, 3)
                .repeat(15)(
                    exec(http("data_request")
                        .get("/data")
                        .headers(headers_0))
                    .pause(1, 5)
                )

        setUp(
            scn.inject(rampUsers(250) during (60 seconds))
        ).protocols(httpProtocol)
}