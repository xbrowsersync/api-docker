const http = require("http")
const options = {
  host: "0.0.0.0",
  port: 8080,
  method: "GET",
  path: "/info",
  timeout: 2000
}

const healthCheck = http.request(options, res => {
  let body = ""

  res.setEncoding("utf8")
  res.on("data", chunk => (body += chunk))
  res.on("end", () => {
    if (res.statusCode === 200) {
      let payload = JSON.parse(body)
      if (payload.status === 1) {
        console.log(`HEALTHCHECK (v${payload.version}): online`)
        process.exit(0)
      } else if (payload.status === 2) {
        console.log(`HEALTHCHECK (v${payload.version}): offline`)
      } else if (payload.status === 3) {
        console.log(
          `HEALTHCHECK (v${payload.version}): not accepting new syncs`
        )
      } else {
        console.log(
          `HEALTHCHECK (v${payload.version}): unknown (status: ${payload.status})`
        )
      }
    } else {
      console.log(`HEALTHCHECK: ${res.statusCode}`)
    }
    process.exit(1)
  })
})

healthCheck.on("error", function(err) {
  console.error(`ERROR ${err}`)
  process.exit(1)
})

healthCheck.end()
