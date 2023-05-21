# HSL-Frontend

## Welcome to HSl Frontend Application.

Backend: [Backend Repository](https://github.com/Ahmad-Imam/HSL-Backend)

## Frontend Information

The project uses Flutter and is developed as a mobile application. You can run the frontend on android device by installing flutter and dart on your local machine and run the main file. Or you can directly install the hsl_frontend apk on your android device.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Frontend Instructions

1. You can directly install the apk - hsl_frontend_app on your Android phone and run the application
2. If you want to run locally then clone the project
3. Install flutter in your local machine
4. run - pub get
5. run - flutter build
6. Connect any android mobile in debug mode.
7. run - flutter run
8. Wait for a few moments to establish connection and fetch data.
9. Enjoy !!!

## Frontend Features

1. 4 different functionality

2. Journey List shows all the journeys included in the first csv file given in the exercise github (https://dev.hsl.fi/citybikes/od-trips-2021/2021-05.csv). Scroll to bottom to see all the journeys as they are loaded. Click on the top right icon to go to the first/last part of the page.

3. Station List shows all the station information included in the dataset about station information given in the exercise github. (https://opendata.arcgis.com/datasets/726277c507ef4914b0aec3cbcfcbfafc_0.csv). Scroll top to bottom to see all the journeys. Click on the top right icon to go to the first/last part of the page. Click on a row to view specific information about a station.

4. Single station has properties like station name, address, station location on the map ,total number of journeys starting from the station, total number of journeys ending at the stationStation location on the map, the average distance of a journey starting from the station, the average distance of a journey ending at the station on the page.

5. Add Journey enables to create new journey information based on the user input. The new journey data is sent to the backend and written on the csv file.

6. Add Station enables to create new station information based on the user input. The new station data is sent to the backend and written on the csv file.

## Sample Screenshots

![createjourney](https://github.com/Ahmad-Imam/HSL-Backend-APP/assets/38004971/7ea713f0-ae69-41bf-a622-644e95ef9562)
![home](https://github.com/Ahmad-Imam/HSL-Backend-APP/assets/38004971/563f9bae-a0ba-4f4b-a2b8-9e207066ea61)
![journeylist](https://github.com/Ahmad-Imam/HSL-Backend-APP/assets/38004971/a6066347-0a37-4366-824c-86d4013e1c4e)
![singlestation](https://github.com/Ahmad-Imam/HSL-Backend-APP/assets/38004971/13142419-d611-45d2-8f6c-c1473a919a87)
![station](https://github.com/Ahmad-Imam/HSL-Backend-APP/assets/38004971/6d7de069-5955-4cc7-93cd-b9687f390863)
![stationlist](https://github.com/Ahmad-Imam/HSL-Backend-APP/assets/38004971/2ab7bc04-9686-402f-91f4-29fe637aeff7)

## Application Information

The application consists of a separate frontend and backend repository.

- Technology: Frontend: Flutter, Backend: NodeJS, Docker, Heroku

- The frontend is designed as a mobile application and contains an apk in the repository to install. Unfortunately it is not possible to run the application in ios device as I do not have access to an iphone but incase of ios it will use the same codebase by using the power of cross-platform development in flutter.

- The backend is written in NodeJs and it needs the installation of npm and node to run the backend. The backend is containerized and it is also hosted in Heroku.

## Application Features

- Users can view all the journey information from the first dataset given in the exercise github. Scroll to bottom to see more journeys as they are loaded.

- Users can view all the station information from the dataset given in the exercise github. Scroll top to bottom to see all the stations. All of them are in a pagination.

- Click on one station from the list to see information about a specific station which includes location on the map, station name, address, total number of journeys starting from the station, total number of journeys ending at the station, the average distance of a journey starting from the station, the average distance of a journey ending at the station.

- Add new journey information by filling up the information required.

- Add new station information by filling up the information required.
