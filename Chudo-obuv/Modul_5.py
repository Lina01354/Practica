'''import pandas as pd

s = pd.read_csv('Sessions_analytics.csv')
o = pd.read_csv('Orders_analytics.csv')

v = s.groupby('device_type')['user_id'].nunique()

c = o[o['order_status'] == 'completed']
bs= c[['session_id']].merge(
    s[['session_id', 'user_id', 'device_type']], on='session_id'
)
b = bs.groupby('device_type')['user_id'].nunique()

c = b / v

print(c)
print(c.idxmax())'''

'''import pandas as pd

s = pd.read_csv('Sessions_analytics.csv')
o = pd.read_csv('Orders_analytics.csv')

s['session_start'] = pd.to_datetime(s['session_start'])
o['order_datetime'] = pd.to_datetime(o['order_datetime'])

fs = s.groupby('user_id')['session_start'].min().reset_index()
fs.columns = ['user_id', 'first_session']

co = o[o['order_status'] == 'completed']
fo = co.groupby('user_id')['order_datetime'].min().reset_index()
fo.columns = ['user_id', 'first_order']

df = fs.merge(fo, on='user_id')
df['diff_minutes'] = (df['first_order'] - df['first_session']).dt.total_seconds() / 60
dft = df[df['diff_minutes'] <= 10080]

mt = dft['diff_minutes'].median()

print(len(dft))
print(mt)'''

'''import pandas as pd

df = pd.read_csv('Sessions_analytics.csv')
df['session_start'] = pd.to_datetime(df['session_start'])

first_sessions = df.sort_values('session_start').drop_duplicates(subset=['user_id'], keep='first')

jan_users = first_sessions[
    (first_sessions['session_start'].dt.year == 2026) &
    (first_sessions['session_start'].dt.month == 1)
].copy()

jan_user_ids = jan_users['user_id'].tolist()

feb_sessions = df[
    (df['user_id'].isin(jan_user_ids)) &
    (df['session_start'].dt.year == 2026) &
    (df['session_start'].dt.month == 2)
]

returned_user_ids = feb_sessions['user_id'].unique()
jan_users['returned'] = jan_users['user_id'].isin(returned_user_ids)

retention_by_channel = jan_users.groupby('traffic_source')['returned'].mean()

best_channel = retention_by_channel.idxmax()
max_retention = retention_by_channel.max()

print(retention_by_channel.sort_values(ascending=False).apply(lambda x: f"{x:.1%}"))
print(f"\nКанал с максимальным удержанием: {best_channel.upper()} ({max_retention:.1%})")
'''

'''import pandas as pd

o = pd.read_csv('Orders_analytics.csv')
i = pd.read_csv('Order_items_analytics.csv')

c = o[o['order_status'] == 'completed']['order_id']

ot = i[i['order_id'].isin(c)].groupby('order_id')['item_total'].sum()

q1 = ot.quantile(0.25)
q3 = ot.quantile(0.75)
iqr = q3 - q1

l = q1 - 1.5 * iqr
u = q3 - 1.5 * iqr

f = ot[(ot >= l) & (ot <= u)]
print(len(f))'''

'''import pandas as pd

o = pd.read_csv('Orders_analytics.csv')
i = pd.read_csv('Order_items_analytics.csv')

c = o[o['order_status'] == 'completed']['order_id']
d = i[i['order_id'].isin(c)]

r = d['discount_percent'].corr(d['quantity'])
print(r)
'''

import pandas as pd

o = pd.read_csv('Orders_analytics.csv')
i = pd.read_csv('Order_items_analytics.csv')
m = pd.read_csv('Shoe_models_analytics.csv')

c = o[o['order_status'] == 'completed']['order_id']
d = i[i['order_id'].isin(c)].merge(
    m[['model_id', 'category']], on='model_id'
)

r = d.groupby('category')['quantity'].sum().sort_values(ascending=False)
print(r.idxmax())