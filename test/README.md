# Test Configuration

This directory contains comprehensive tests for the Nostr Relay Management API package.

## Test Structure

- `nostr_relay_management_api_test.dart` - Main package tests
- `models_test.dart` - Model class tests (AllowedPubkeyInfo, BannedEventInfo, etc.)
- `methods_service_test.dart` - Methods service tests with mocked networker
- `networker_test.dart` - Networker tests (basic structure tests)
- `integration_test.dart` - Integration tests with real relay (requires running relay)

## Running Tests

```bash
# Run all tests
dart test

# Run specific test file
dart test test/models_test.dart

# Run tests with coverage
dart test --coverage=coverage
```

## Test Categories

### Unit Tests
- Model serialization/deserialization
- Method parameter validation
- Service method calls with mocked dependencies

### Integration Tests
- Real relay communication (requires running relay server)
- Error handling with invalid inputs
- Authentication flow testing

## Mock Setup

The tests use Mockito for mocking HTTP requests. To generate mocks:

```bash
dart run build_runner build
```

## Test Data

Tests use realistic test data that matches NIP-86 specifications:
- Valid Nostr pubkeys (npub1...)
- Realistic event IDs
- Proper IP addresses
- Standard event kinds (0, 1, 3, etc.)
