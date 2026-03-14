# Explore & Globe Hub — Functional Requirements

**Assignee:** Unassigned
**Status:** Not Started
**Phase:** P1: Core App

---

## Overview

3D interactive globe for destination discovery. Users explore countries, add to wishlists, see where friends have been and want to go. Social discovery layer on top of trip planning.

## Features

| Feature | Description |
|---------|-------------|
| 3D Globe | Interactive spinning globe with country highlighting |
| Country Wishlist | Tap country → add to "want to visit" list |
| Friend Overlay | See where friends have been (dots) and want to go (pins) |
| Place Discovery | Trending destinations, friend recommendations |
| Trip Cloning | See a friend's public trip → "Clone this trip" |
| Public Trips | Browse public trips from the community |

## Screens

Part of the Explore tab (bottom nav). Includes:
- Globe view (default)
- Country detail (tap country → stats, friends who've been, trips there)
- Wishlist (saved countries)
- Discover feed (public trips, trending destinations)
- Friend activity (where friends are going next)

## Technical Notes

- Globe rendering: react-native-gl or Three.js via expo-gl
- Country data: GeoJSON boundaries
- Friend overlay: query `user_profiles` for travel history
- Performance: LOD (level of detail) for globe rendering on lower-end devices

## Dependencies

- User profiles with travel history
- Public trip publishing system
- Friend/follow system
