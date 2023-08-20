raw_ACE = readtable("20031030_ace_mag_1m.csv");

% interpolate the data to 1 minute intervals


missing_ACE = standardizeMissing(raw_ACE,-999.9);
interp_ACE = fillmissing(missing_ACE, "linear");

writetable(interp_ACE, "20031030_ACE_interp.csv");