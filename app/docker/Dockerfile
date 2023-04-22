# Best Practices
## 1. Keeping docker file in empty dir - to avoid unnecessary file transfers
## 2. Using official and minimal base image - this one approx 45mb
FROM python:3.7.16-slim

## 3. Adding label to show metadata
LABEL maintainer="tejas@somethingblablabla.com"

COPY ../main.py .

# Copy env file to image not a good practice - instead of this we should have
# used external secret manager ie. vault, AWS Secret manager etc. To deploy fast
# copying .env file
COPY ../.env .

EXPOSE 5000

CMD ["/bin/bash", "-c", "source .env; python main.py"]

# More Best Practices
## 4. Multi-Stage Builds - in the above scenario we don't have to build something hence not used multi-stage
## build.
## 5. Static Code Analysis - Should be perform before building container image
## 6. Vulnerability Scan should be performed
## 7. Verify and Sign images

