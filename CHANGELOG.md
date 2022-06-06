# Changelog

All notable changes to this project will be documented in this file.

## Unreleased

## 1.2.1 - 2022-04-11

- 15: Keep the previous certificate in the bundle as well as the new one to prevent periods of service outage

## 1.2.0 - 2022-04-11

- 13: Add support for ARM64

## 1.1.3 - 2022-01-23

- 8: FIX: User nonroot lost write access to kubemod-crt after 1.1.2

## 1.1.2 - 2022-01-21

- 4: FIX: Scripts cannot write to /kubemod-crt directory under some scenarios

## 1.1.1 - 2021-04-01

- Split apply script into create-secret and patch-controllers

## 1.1.0 - 2020-10-18

- 3: Split renew-certificates.sh
- 1: Make kubemod-crt run as non-root

## 1.0.0 - 2020-10-18

Initial release
