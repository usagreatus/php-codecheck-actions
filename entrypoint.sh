#!/bin/sh

cd "$GITHUB_WORKSPACE/${INPUT_DIRECTORY}"

/usr/local/bin/phpcs.phar \
    --report=summary \
    --report-checkstyle=/tmp/phpcs_result_checkstyle.xml \
    -p -s --colors -d memory_limit=1G --ignore=vendor --extensions=php \
    --standard=./phpcs.xml \
    ${INPUT_PHPCS_ARGS:-\.}

cat /tmp/phpcs_result_checkstyle.xml | reviewdog -f=checkstyle -name="phpcs" -reporter="${INPUT_REPORTER:-github-pr-check}" -level="${INPUT_LEVEL}"

EXIT_CODE1=$?

/usr/local/bin/phpmd.phar ${INPUT_PHPMD_ARGS:-\.} text ./phpmd.xml -dmemory_limit=-1 > /tmp/phpmd-report.txt

EXIT_CODE2=$?

if [ $EXIT_CODE1 != 0 ] || [ $EXIT_CODE2 != 0 ] ; then
  exit 1;
fi
