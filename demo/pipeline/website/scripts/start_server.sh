#!/bin/bash
isExistApp = `pgrep nginx`
if [[ -z  $isExistApp ]]; then
    service nginx start        
fi