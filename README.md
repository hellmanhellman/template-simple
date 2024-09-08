# Simple HTMX + express starter with Tailwind CSS

This project is a simple Node.js application that demonstrates the use of HTMX and Tailwind CSS. It provides a basic setup for creating interactive web applications with minimal JavaScript.

## Features

- Express.js server
- HTMX for dynamic content loading
- Tailwind CSS for styling
- Docker support for easy deployment

## Prerequisites

- Node.js (version specified in `.nvmrc`)
- npm (recommended package manager)

## Installation

1. Clone the repository
2. Install dependencies:

```bash
npm install
```

## Usage

### Development

To run the application in development mode:

```bash
npm run dev
```

This command will:
- Watch for CSS changes and recompile
- Start the server with nodemon for auto-reloading
- Open the application in your default browser

### Production

To build and start the application for production:

```bash
npm run build:css
npm start
```

### Docker

To build and run the application using Docker:

```bash
npm run docker:build
npm run docker:run
```

## Project Structure

- `server.js`: Express server setup
- `scripts/`: Scripts
  - `setup_simple.sh`: Script to make the project without cloning the repo
- `public/`: Static files
  - `index.html`: Main HTML file
  - `css/`: CSS files
- `tailwind.config.js`: Tailwind CSS configuration
- `postcss.config.js`: PostCSS configuration
- `Dockerfile`: Docker configuration

## Scripts

```json:package.json
startLine: 6
endLine: 13
```

## License

ISC

## Contributing

Contributions are welcome. Please open an issue or submit a pull request.