##calculate single day 
import matplotlib.pyplot as plt
from sklearn.tree import DecisionTreeRegressor 
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.metrics import roc_auc_score
from sklearn.linear_model import LogisticRegression
from sklearn.preprocessing import StandardScaler
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import roc_curve, auc
import xgboost as xgb
import shap

# 读取excel文件数据
df = pd.read_excel('E:/NEW/CHINANEW.xlsx', sheet_name='ALL')

# 删除包含NaN值的行
df1= df[~np.any(nan_indices, axis=1)]
m=900
t=6726

o_target = df1['occur'][m:t]
Terr=df1.iloc[m:t, 4:10]
HRLT=df1.iloc[m:t, 11:15]
MSWEP=df1.iloc[m:t, 15:19]
CHIRPS=df1.iloc[m:t, 19:23]
SM=df1.iloc[m:t, 23:27]
RW=df1.iloc[m:t, 29:31]
factors = pd.concat([HRLT.iloc[:, i], SM.iloc[:, j],Terr,RW], axis=1)
# 标准化处理
scaler = StandardScaler()
factors_scaled = scaler.fit_transform(factors)
# Randomly select 80% of the data for training
X_train, X_test, y_train, y_test = train_test_split(factors_scaled, o_target, test_size=0.20, random_state=42)
# Train your model using the training set
rf = RandomForestRegressor(n_estimators=1000, criterion='squared_error', max_features='log2', bootstrap=True, n_jobs=-1, oob_score=True)
rf.fit(X_train, y_train)
importancesrf = rf.feature_importances_#因子重要性计算
# Predict the remaining 20% of the data
yrf_pred = rf.predict(X_test)
# Calculate the AUC
rfauc1 = roc_auc_score(y_test, yrf_pred)   
        
plt.figure(1)
y_rf_prob = rf.predict(X_test)
fpr_rf, tpr_rf, _ = roc_curve(y_test, y_rf_prob)
# Compute the area under the ROC curve (AUC)
auc_rf = auc(fpr_rf, tpr_rf)
# Plot the ROC curve
plt.plot(fpr_rf, tpr_rf, label='Random Forest (AUC = %0.2f)' % auc_rf)

plt.plot([0, 1], [0, 1], 'r--')
plt.xlim([0, 1])
plt.ylim([0, 1])
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('Receiver Operating Characteristic')
plt.legend(loc='lower right')

# Display the plot
plt.show()








   




 


