# Docker image for running java-based selenium test with a headless chromium browser

## Example

```
rm -rf /tmp/selenium-testrunner/
mkdir -p /tmp/selenium-testrunner
time docker run -t \
    --rm \
    --shm-size=1024m \
    --cap-add=SYS_ADMIN \
    -v $(pwd)/autotest:/autotest \
    -v /tmp:/tmp \
    -e "AUTOTEST_VB_TARGET_BASE_URL=https://test.videoblocks.com" \
    -e "AUTOTEST_GS_TARGET_BASE_URL=https://test.storyblocks.com/stock-image" \
    -e "AUTOTEST_AB_TARGET_BASE_URL=https://test.audioblocks.com" \
    -e "AUTOTEST_RETRY_COUNT=1" \
    -e "reportDir=/tmp/selenium-testrunner" \
    -e "outputSnippets=/tmp/selenium-testrunner/snippets.xml" \
    videoblocks/selenium-testrunner \
    "env && ant runtest -f /autotest/build.xml -Dtest=TestVBJoinBrowse -Dmethods=testAnnualOnlySignUp"
```