def convert_date(original)
	original.gsub(/[.]/, '-')
end

def paymode(zahlungsart)

	case zahlungsart
		when "DAUERAUFTRAG"
			8
		when "FOLGELASTSCHRIFT"
			12
		when "ONLINE-UEBERWEISUNG" || "GUTSCHRIFT"
			5
		when "KARTENZAHLUNG"
			9
		when "WIEDERGUTSCHRIFT"
			10
		else 
			0
	end

end

datei = File.open('umsatz.csv','rb')
umsaetze = datei.read.to_s
datei.close
eintraege = umsaetze.split(";")
#eintraege zaehlen
count = eintraege.length/11
eintraege.collect! do |eintrag|
	eintrag.gsub(/[""]/, "")
end

count.times do |index|
	eintrag = []
	eintraege = eintraege[10..(eintraege.length+1)]
	eintrag << convert_date(eintraege[1]) << paymode(eintraege[3])
	eintrag << "" << eintraege[5] << "" << eintraege[8] 
	eintrag << "" << "\n"  
	File.open("formatiert.csv", "a") {|f| f.write(eintrag.join(';'))}
end












