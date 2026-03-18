# Meetily Root Makefile

.PHONY: all help install dev build clean backend-install backend-start

# Default target
all: help

help:
	@echo "Meetily Build System"
	@echo "Usage:"
	@echo "  make install        - Install all dependencies (frontend & backend)"
	@echo "  make dev            - Run the app in development mode (Next.js + Tauri)"
	@echo "  make build          - Build the production version of the app"
	@echo "  make clean          - Clean build artifacts"
	@echo ""
	@echo "Backend targets:"
	@echo "  make backend-install - Install Python backend dependencies"
	@echo "  make backend-start   - Start the Python FastAPI backend"

# Installation
install:
	@echo "Installing frontend dependencies..."
	cd frontend && npm install
	@echo "Installing Rust dependencies..."
	cargo fetch
	@$(MAKE) backend-install

# Development
dev:
	@echo "Starting Meetily in development mode..."
	cd frontend && npm run tauri:dev

# Build
build:
	@echo "Building Meetily for production..."
	cd frontend && npm run tauri:build

# Backend management
backend-install:
	@echo "Setting up Python virtual environment and installing dependencies..."
	cd backend && if [ ! -d "venv" ]; then python3.13 -m venv venv; fi
	cd backend && ./venv/bin/pip install -r requirements.txt

backend-start:
	@echo "Starting Python backend..."
	cd backend && ./venv/bin/python app/main.py

# Cleanup
clean:
	@echo "Cleaning artifacts..."
	rm -rf frontend/.next
	rm -rf frontend/out
	cargo clean
