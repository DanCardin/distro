function scanimg --wraps='trivy image --report summary --severity=HIGH,CRITICAL --ignore-unfixed' --description 'alias scanimg=trivy image --report summary --severity=HIGH,CRITICAL --ignore-unfixed'
    trivy image --report summary --severity=HIGH,CRITICAL --ignore-unfixed $argv
end
