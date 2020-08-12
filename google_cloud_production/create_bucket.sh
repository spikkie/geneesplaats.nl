#!/usr/bin/env bash
set -x

TOKEN=ya29.Il-9B_Y_wU_e33PxzpwpZcj5C1d-QVCffJ996SKK2syDHLFe8AzlezAOeh5ZtECv3tEDDMEoRWsi3nFdLeNYIl3yIaNejFz9mmrPQ0kTKSYfH_KnqZUGQ-tmoSXQV7ohjg

curl -X POST --data-binary @bucket.json \
     -H "Authorization: Bearer ${TOKEN}" \
     -H "Content-Type: application/json" \
     "https://storage.googleapis.com/storage/v1/b?project=stoked-axle-267521"
