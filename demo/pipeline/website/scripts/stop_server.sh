#!/bin/bash
isExistApp = `pgrep nginx`
if [[ -n  $isExistApp ]]; then
    service nginx stop        
fi