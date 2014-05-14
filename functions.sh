#!/bin/bash
kbn() {
    ps -aef | grep $1 | grep -v grep | tr -s ' ' | cut -f 2 -d ' ' | xargs kill
}
export -f kbn
