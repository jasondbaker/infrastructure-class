package webapp

import scala.concurrent.duration._

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import io.gatling.jdbc.Predef._

class RecordedSimulation extends Simulation {

        private val times = 1 to 10

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

        object GetNames1 {
            val getnames = exec(_.set("times", times))
                .repeat("${times.random()}")(
                        exec(http("request_Suri")
                                .get("/")
                                .headers(headers_0)
                                .resources(http("request_1")
                                .get("/Suri")
                                .headers(headers_1)))
                        .pause(1, 5)                  
                )
                .exec(http("request_Suri")
                        .get("/")
                        .headers(headers_0)
                        .resources(http("request_1")
                        .get("/Suri")
                        .headers(headers_1)))
                .pause(1, 5)
                .exec(http("request_Mark")
                        .get("/Mark")
                        .headers(headers_0))
                .pause(1, 5)
        }

        object GetNames2 {
            val getnames = exec(http("request_Alicia")
                .get("/Alicia")
                .headers(headers_0))
                .pause(1, 5)
                .exec(http("request_Toni")
                    .get("/Toni")
                    .headers(headers_0))
                .pause(1, 5)
                .exec(http("request_Roberto")
                    .get("/Roberto")
                    .headers(headers_0))
                .pause(1, 5)
        }

        object GetData {
            val getdata = repeat(30)(
                    exec(http("data_request")
                        .get("/data")
                        .headers(headers_0))
                    .pause(1, 5)
                )
        }
        object BadRequest {
            val badrequest = exec(http("request_error")
                .get("/data/data")
                .headers(headers_0)
                .check(
                        status.is(404)
                ))
                .pause(1, 5)
        }

        val group1 = scenario("Group1").exec(GetNames1.getnames, GetData.getdata)
        val group2 = scenario("Group2").exec(GetNames2.getnames, GetData.getdata, BadRequest.badrequest)

                

        setUp(
            group1.inject(rampUsers(400) during (180 seconds)),
            group2.inject(rampUsers(100) during (60 seconds))
        ).protocols(httpProtocol)
}