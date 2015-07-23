import numpy as np

datakeys = [u'EMXP', u'MXSD', u'TPCP', 
	        u'TSNW', u'EMXT', u'EMNT', 
			u'MMXT', u'MMNT', u'MNTM']
				
def filter_city(df, city_filter):
	inds = [sn.endswith(city_filter) 
			for sn in df['STATION_NAME']]
	city = df[inds]
	for dk in datakeys:
		city[dk][city[dk]==-9999]= np.nan

	return city.groupby('DATE').mean()