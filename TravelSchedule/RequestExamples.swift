import Foundation
import OpenAPIURLSession
import OpenAPIRuntime


final class RequestExamples {
    
    private static func createClient(apiKey: String) -> Client {
        let middlewares: [ClientMiddleware] = [
            AuthorizationMiddleware(apiKey: apiKey)
        ]
        do {
            return Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport(),
                middlewares: middlewares
            )
        } catch {
            print("Error creating client: \(error)")
            preconditionFailure()
        }
    }
    
    static func testFetchStations() {
        Task {
            do {
                let client = createClient(apiKey: GlobalParams.apiKey)

                let service = NearestStationsService(
                    client: client,
                    apiKey: GlobalParams.apiKey
                )
                print("Fetching stations...")
                let stations = try await service.getNearestStations(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 50
                )
                print("Successfully fetched stations: \(stations)")
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    static func testSearch() {
        Task {
            do {
                let client = createClient(apiKey: GlobalParams.apiKey)
                let service = ScheduleBetweenStationsService(
                    client: client,
                    apiKey: GlobalParams.apiKey
                )
                print("Fetching search...")
                let search = try await service.getScheduleBetweenStations(
                    from: "c146",
                    to: "c213"
                )
                print("Successfully fetched search: \(search)")
            } catch {
                print("Error fetching search: \(error)")
            }
        }
    }
    
    static func testListStation() {
        Task {
            do {
                let client = createClient(apiKey: GlobalParams.apiKey)
                let service = StationScheduleService(
                    client: client,
                    apiKey: GlobalParams.apiKey
                )
                print("Fetching list stations...")
                let listStation = try await service.getStationSchedule(
                    station: "s9600213"
                )
                print("Successfully fetched list stations: \(listStation)")
            } catch {
                print("Error fetching list stations: \(error)")
            }
        }
    }
    
    static func testThread() {
        Task {
            do {
                let client = createClient(apiKey: GlobalParams.apiKey)
                let service = RouteStationsService(
                    client: client,
                    apiKey: GlobalParams.apiKey
                )
                print("Fetching thread...")
                let thread = try await service.getRouteStations(
                    uid: "028S_4_2"
                )
                print("Successfully fetched thread: \(thread)")
            } catch {
                print("Error fetching thread: \(error)")
            }
        }
    }
    
    static func testFetchCity() {
        Task {
            do {
                let client = createClient(apiKey: GlobalParams.apiKey)
                let service = NearestCityService(
                    client: client,
                    apiKey: GlobalParams.apiKey
                )
                print("Fetching city...")
                let settlements = try await service.getNearestCity(
                    lat: 54.513678,
                    lng: 36.261341
                )
                print("Successfully fetched city: \(settlements)")
            } catch {
                print("Error fetching city: \(error)")
            }
        }
    }
    
    static func testCopyright() {
        Task {
            do {
                let client = createClient(apiKey: GlobalParams.apiKey)
                let service = CopyrightService(
                    client: client,
                    apiKey: GlobalParams.apiKey
                )
                print("Fetching copyright...")
                let copyright = try await service.getCopyright()
                print("Successfully fetched copyright: \(copyright)")
            } catch {
                print("Error fetching copyright: \(error)")
            }
        }
    }
    
    static func testCarrierInfo() {
        Task {
            do {
                let client = createClient(apiKey: GlobalParams.apiKey)
                let service = CarrierInfoService(
                    client: client,
                    apiKey: GlobalParams.apiKey
                )
                print("Fetching carriers...")
                let carriersInfo = try await service.getCarrierInfo(code: "680")
                print("Successfully fetched carriers: \(carriersInfo)")
            } catch {
                print("Error fetching carriers: \(error)")
            }
        }
    }
    
    static func testAllStations() {
        Task {
            do {
                let client = createClient(apiKey: GlobalParams.apiKey)
                let service = AllStationsService(
                    client: client,
                    apiKey: GlobalParams.apiKey
                )
                print("Fetching stations all...")
                let stationsAll = try await service.getAllStations()
                let countries = stationsAll.countries?.map(\.title) ?? []
                print("Successfully fetched all stations \(countries)")
                let countriesCount = stationsAll.countries?.count ?? 0
                print("Successfully fetched \(countriesCount) countries")
            } catch {
                print("Error fetching stations all: \(error)")
            }
        }
    }
}
