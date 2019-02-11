#!/bin/bash

strXml='
<?xml version="1.0"?>
<data>
	<country name="Liechtenstein">
		<rank>1</rank>
		<year>2008</year>
		<gdppc>141100</gdppc>
		<neighbor name="Austria" direction="E"/>
		<neighbor name="Switzerland" direction="W"/>
	</country>
	<country name="Singapore">
		<rank>4</rank>
		<year>2011</year>
		<gdppc>59900</gdppc>
		<neighbor name="Malaysia" direction="N"/>
	</country>
	<country name="Panama">
		<rank>68</rank>
		<year>2011</year>
		<gdppc>13600</gdppc>
		<neighbor name="Costa_Rica" direction="W"/>
		<neighbor name="Colombia" direction="E"/>
	</country>
</data>'

#echo $strXml | xmllint --xpath '//country' -
#echo $strXml | xmllint --xpath '//country/text()' -
#echo $strXml | xmllint --xpath '//country/@name' -
#echo $strXml | xmllint --xpath '//country' -
#echo $strXml | xmllint --xpath '//country/neighbor/@name' -
#echo $strXml | xmllint --xpath '//country/neighbor/@direction' -

arrCountries=($(echo $strXml | xmllint --xpath '//country/@name' - | sed -e 's/name=//g' -e 's/\"//g'))
#arrCountries=$(echo $strXml | xmllint --xpath '//country/@name' - | awk -F"\"" '{print $2}')
for item in ${arrCountries[@]}; do
	echo "Country: ${item}"
	strTag=$(echo $strXml | xmllint --xpath "string(//country[@name=\"${item}\"]/rank)" -)
	echo "rank: ${strTag}"
	strYear=$(echo $strXml | xmllint --xpath "string(//country[@name=\"${item}\"]/year)" -)
	echo "year: ${strYear}"
	strGdppc=$(echo $strXml | xmllint --xpath "string(//country[@name=\"${item}\"]/gdppc)" -)
	echo "gdppc: ${strGdppc}"
	arrNeighborName=$(echo $strXml | xmllint --xpath "//country[@name=\"${item}\"]/neighbor/@name" - | sed -e 's/name=//g' -e 's/\"//g')
	for item in ${arrNeighborName[@]}; do
		echo "Neigbor: ${item}"
		arrNeighborDir=$(echo $strXml | xmllint --xpath "//country/neighbor[@name=\"${item}\"]/@direction" - | sed -e 's/direction=//g' -e 's/\"//g')
		for item in ${arrNeighborDir[@]}; do
			echo "Direction: ${item}"
		done
	done
	echo ''
done
echo ''
