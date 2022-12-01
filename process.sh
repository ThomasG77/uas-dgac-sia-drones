jq -c '.features[] | {"identifier": .identifier} + .geometry[]' \
   UASZones_2022-12-01_20221118.json \
   | ndjson-map -r turf=@turf/turf 'j = d.horizontalProjection.type != "Circle" ? {"type": "Feature","properties": {}, "geometry": d.horizontalProjection} : turf.buffer({"type": "Feature","properties": {}, "geometry": {"coordinates": d.horizontalProjection.center, "type": "Point"}}, d.horizontalProjection.radius / 1000), j.properties = {"identifier": d.identifier, "type": d.horizontalProjection.type, "lowerLimit": d.lowerLimit, "lowerVerticalReference": d.lowerVerticalReference, "uomDimensions": d.uomDimensions, "upperLimit": d.upperLimit, "upperVerticalReference": d.upperVerticalReference}, d = j, d' \
   | ndjson-reduce 'p.features.push(d), p' '{type: "FeatureCollection", features: []}' \
   >| UASZones_2022-12-01_20221118.geojson


 jq -c -r '[.features[] | {"applicability": (if .applicability[0] then .applicability[0].permanent else null end), "country": .country, "identifier": .identifier, "message": .message, "name": .name, "otherReasonInfo": .otherReasonInfo, "reason": (.reason | join(",")), "region": .region, "regulationExemption": .regulationExemption, "restriction": .restriction, "restrictionConditions": .restrictionConditions, "type": .type, "uSpaceClass": .uSpaceClass, "zoneAuthority_contactName": .zoneAuthority[0].contactName, "zoneAuthority_email": .zoneAuthority[0].email, "zoneAuthority_intervalBefore": .zoneAuthority[0].intervalBefore, "zoneAuthority_name": .zoneAuthority[0].name, "zoneAuthority_phone": .zoneAuthority[0].phone, "zoneAuthority_purpose": .zoneAuthority[0].purpose, "zoneAuthority_service": .zoneAuthority[0].service, "zoneAuthority_siteURL": .zoneAuthority[0].siteURL}] | (.[0] | to_entries | map(.key)), (.[] | [.[]]) | @csv' \
    UASZones_2022-12-01_20221118.json \
    >| UASZones_2022-12-01_20221118.csv
