FROM openjdk:8-jdk-slim

# Build time variables
ARG MTA_USER_HOME=/home/mta
ARG MBT_VERSION=1.0.10
ARG GO_VERSION=1.13.5
ARG NODE_VERSION=v12.13.1
ARG MAVEN_VERSION=3.6.3
