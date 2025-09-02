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

# 读取CSV文件数据

df = pd.read_excel('E:/降水-土壤水分和地形推求地灾发生概率/灾害的P和SSM/NEW/CHINAlandslidesSM.xlsx', sheet_name='ALL')
#df = pd.read_excel('E:/降水-土壤水分和地形推求地灾发生概率/灾害的P和SSM/GBA.xlsx', sheet_name='Sheet3')
# 提取经纬度和日期列
#factors = df.iloc[:, 1:10]

# 查找包含NaN值的索引
nan_indices = np.isnan(df)

# 删除包含NaN值的行
df2= df[~np.any(nan_indices, axis=1)]
#df2 =df1[df1['LUC'] != 8]


#df2 =df1[df1['LUC'] != 8]
#df2 = df1[df1['LUC'] == 8]

# o_target = df1['occur']
# Terr=df1.iloc[:, 0:7]
# rain=df1.iloc[:, 7:11]
# SM=df1.iloc[:, 11:15]
# land=df1['CLCD2007']
# factors = pd.concat([rain.iloc[:, 2], SM.iloc[:, 0], Terr,land], axis=1)
#所有区域
m=600
#t=5522

#m=900
#t=6726
#m=0
t=6621


#城市区域
#m=100
#t=699

#非城市区域
#m=0
#t=2500

o_target = df2['occur'][m:t]
Terr=df2.iloc[m:t, 4:10]
HRLT=df2.iloc[m:t, 11:15]
MSWEP=df2.iloc[m:t, 15:19]
GPM=df2.iloc[m:t, 19:23]
CHIRPS=df2.iloc[m:t, 23:27]

SM=df2.iloc[m:t, 27:33]
RW=df2.iloc[m:t, 35:37]
# #目前来说 累积72小时降水和表层土壤水分更适合建模

# 创建一个空列表来存储每次计算的AUC值
auc_scores1 = []
auc_scores2 = []
auc_scores3 = []
auc_scores4 = []

for _ in range(3):
    temp_scores1 = [] 
    temp_scores2 = []
    temp_scores3 = [] 
    temp_scores4 = []
    for i in range(4):
        for j in range(4): 
            factors = pd.concat([HRLT.iloc[:, i], SM.iloc[:, j],Terr,RW], axis=1)
# 标准化处理
            scaler = StandardScaler()
            factors_scaled = scaler.fit_transform(factors)
# Randomly select 70% of the data for training
            X_train, X_test, y_train, y_test = train_test_split(factors_scaled, o_target, test_size=0.20, random_state=42)
# Train your model using the training set
            rf = RandomForestRegressor(n_estimators=1000, criterion='squared_error', max_features='log2', bootstrap=True, n_jobs=-1, oob_score=True)
            rf.fit(X_train, y_train)
            importancesrf = rf.feature_importances_
# Predict the remaining 30% of the data
            yrf_pred = rf.predict(X_test)
# Calculate the AUC
            rfauc1 = roc_auc_score(y_test, yrf_pred)  
            print(rfauc1)
            temp_scores1.append(rfauc1)
             
            factors = pd.concat([MSWEP.iloc[:, i], SM.iloc[:, j],Terr,RW], axis=1)
# 标准化处理
            scaler = StandardScaler()
            factors_scaled = scaler.fit_transform(factors)
# Randomly select 70% of the data for training
            X_train, X_test, y_train, y_test = train_test_split(factors_scaled, o_target, test_size=0.20, random_state=42)
# Train your model using the training set
            rf = RandomForestRegressor(n_estimators=1000, criterion='squared_error', max_features='log2', bootstrap=True, n_jobs=-1, oob_score=True)
            rf.fit(X_train, y_train)
            importancesrf = rf.feature_importances_
# Predict the remaining 30% of the data
            yrf_pred = rf.predict(X_test)
# Calculate the AUC
            rfauc2 = roc_auc_score(y_test, yrf_pred)   
            temp_scores2.append(rfauc2)
            
        
            factors = pd.concat([CHIRPS.iloc[:, i], SM.iloc[:, j],Terr,RW], axis=1)
# 标准化处理
            scaler = StandardScaler()
            factors_scaled = scaler.fit_transform(factors)
# Randomly select 70% of the data for training
            X_train, X_test, y_train, y_test = train_test_split(factors_scaled, o_target, test_size=0.20, random_state=42)
# Train your model using the training set
            rf = RandomForestRegressor(n_estimators=1000, criterion='squared_error', max_features='log2', bootstrap=True, n_jobs=-1, oob_score=True)
            rf.fit(X_train, y_train)
            importancesrf = rf.feature_importances_
# Predict the remaining 30% of the data
            yrf_pred = rf.predict(X_test)
# Calculate the AUC
            rfauc3 = roc_auc_score(y_test, yrf_pred)   
            temp_scores3.append(rfauc3) 
            
            
            
            factors = pd.concat([GPM.iloc[:, i], SM.iloc[:, j],Terr,RW], axis=1)
# 标准化处理
            scaler = StandardScaler()
            factors_scaled = scaler.fit_transform(factors)
# Randomly select 70% of the data for training
            X_train, X_test, y_train, y_test = train_test_split(factors_scaled, o_target, test_size=0.20, random_state=42)
# Train your model using the training set
            rf = RandomForestRegressor(n_estimators=1000, criterion='squared_error', max_features='log2', bootstrap=True, n_jobs=-1, oob_score=True)
            rf.fit(X_train, y_train)
            importancesrf = rf.feature_importances_
# Predict the remaining 30% of the data
            yrf_pred = rf.predict(X_test)
# Calculate the AUC
            rfauc4 = roc_auc_score(y_test, yrf_pred)   
            temp_scores4.append(rfauc4) 
            
            
    # 将AUC值添加到列表中
    auc_scores1.append(temp_scores1)
    auc_scores2.append(temp_scores2)
    auc_scores3.append(temp_scores3)
    auc_scores4.append(temp_scores4)


auc_scores_a1 = np.array(auc_scores1)
auc_scores_a2 = np.array(auc_scores2)
auc_scores_a3 = np.array(auc_scores3)
auc_scores_a4 = np.array(auc_scores4)

#输出成为txt
np.savetxt('E:/降水-土壤水分和地形推求地灾发生概率/灾害的P和SSM/NEW/urabnandnonurban/HRLT.txt', auc_scores_a1, fmt="%f") 
np.savetxt('E:/降水-土壤水分和地形推求地灾发生概率/灾害的P和SSM/NEW/urabnandnonurban/MSWEP.txt', auc_scores_a2, fmt="%f") 
np.savetxt('E:/降水-土壤水分和地形推求地灾发生概率/灾害的P和SSM/NEW/urabnandnonurban/CHIRPS.txt', auc_scores_a3, fmt="%f") 
np.savetxt('E:/降水-土壤水分和地形推求地灾发生概率/灾害的P和SSM/NEW/urabnandnonurban/GPM.txt', auc_scores_a4, fmt="%f") 

# 删除包含NaN值的行
df3= df[~np.any(nan_indices, axis=1)]
df4 =df3[df3['LUC'] == 8]


#城市区域
m=100
t=699

o_target = df4['occur'][m:t]
Terr=df4.iloc[m:t, 4:10]
HRLT=df4.iloc[m:t, 11:15]
MSWEP=df4.iloc[m:t, 15:19]
GPM=df4.iloc[m:t, 19:23]
CHIRPS=df4.iloc[m:t, 23:27]

SM=df4.iloc[m:t, 27:33]
RW=df4.iloc[m:t, 35:37]


# 创建一个空列表来存储每次计算的AUC值
urbanauc_scores1 = []
urbanauc_scores2 = []
urbanauc_scores3 = []
urbanauc_scores4 = []

for _ in range(20):
    urbantemp_scores1 = [] 
    urbantemp_scores2 = []
    urbantemp_scores3 = [] 
    urbantemp_scores4 = []
    for i in range(4):
        for j in range(4): 
            factors = pd.concat([HRLT.iloc[:, i], SM.iloc[:, j],Terr,RW], axis=1)
# 标准化处理
            scaler = StandardScaler()
            factors_scaled = scaler.fit_transform(factors)
# Randomly select 70% of the data for training
            X_train, X_test, y_train, y_test = train_test_split(factors_scaled, o_target, test_size=0.20, random_state=42)
# Train your model using the training set
            rf = RandomForestRegressor(n_estimators=1000, criterion='squared_error', max_features='log2', bootstrap=True, n_jobs=-1, oob_score=True)
            rf.fit(X_train, y_train)
            importancesrf = rf.feature_importances_
# Predict the remaining 30% of the data
            yrf_pred = rf.predict(X_test)
# Calculate the AUC
            rfauc1 = roc_auc_score(y_test, yrf_pred)  
            print(rfauc1)
            urbantemp_scores1.append(rfauc1)
             
            factors = pd.concat([MSWEP.iloc[:, i], SM.iloc[:, j],Terr,RW], axis=1)
# 标准化处理
            scaler = StandardScaler()
            factors_scaled = scaler.fit_transform(factors)
# Randomly select 70% of the data for training
            X_train, X_test, y_train, y_test = train_test_split(factors_scaled, o_target, test_size=0.20, random_state=42)
# Train your model using the training set
            rf = RandomForestRegressor(n_estimators=1000, criterion='squared_error', max_features='log2', bootstrap=True, n_jobs=-1, oob_score=True)
            rf.fit(X_train, y_train)
            importancesrf = rf.feature_importances_
# Predict the remaining 30% of the data
            yrf_pred = rf.predict(X_test)
# Calculate the AUC
            rfauc2 = roc_auc_score(y_test, yrf_pred)   
            urbantemp_scores2.append(rfauc2)
            
        
            factors = pd.concat([CHIRPS.iloc[:, i], SM.iloc[:, j],Terr,RW], axis=1)
# 标准化处理
            scaler = StandardScaler()
            factors_scaled = scaler.fit_transform(factors)
# Randomly select 70% of the data for training
            X_train, X_test, y_train, y_test = train_test_split(factors_scaled, o_target, test_size=0.20, random_state=42)
# Train your model using the training set
            rf = RandomForestRegressor(n_estimators=1000, criterion='squared_error', max_features='log2', bootstrap=True, n_jobs=-1, oob_score=True)
            rf.fit(X_train, y_train)
            importancesrf = rf.feature_importances_
# Predict the remaining 30% of the data
            yrf_pred = rf.predict(X_test)
# Calculate the AUC
            rfauc3 = roc_auc_score(y_test, yrf_pred)   
            urbantemp_scores3.append(rfauc3) 
            
            
            
            factors = pd.concat([GPM.iloc[:, i], SM.iloc[:, j],Terr,RW], axis=1)
# 标准化处理
            scaler = StandardScaler()
            factors_scaled = scaler.fit_transform(factors)
# Randomly select 70% of the data for training
            X_train, X_test, y_train, y_test = train_test_split(factors_scaled, o_target, test_size=0.20, random_state=42)
# Train your model using the training set
            rf = RandomForestRegressor(n_estimators=1000, criterion='squared_error', max_features='log2', bootstrap=True, n_jobs=-1, oob_score=True)
            rf.fit(X_train, y_train)
            importancesrf = rf.feature_importances_
# Predict the remaining 30% of the data
            yrf_pred = rf.predict(X_test)
# Calculate the AUC
            rfauc4 = roc_auc_score(y_test, yrf_pred)   
            urbantemp_scores4.append(rfauc4) 
            
            
    # 将AUC值添加到列表中
    urbanauc_scores1.append(urbantemp_scores1)
    urbanauc_scores2.append(urbantemp_scores2)
    urbanauc_scores3.append(urbantemp_scores3)
    urbanauc_scores4.append(urbantemp_scores4)


urbanauc_scores_a1 = np.array(urbanauc_scores1)
urbanauc_scores_a2 = np.array(urbanauc_scores2)
urbanauc_scores_a3 = np.array(urbanauc_scores3)
urbanauc_scores_a4 = np.array(urbanauc_scores4)

np.savetxt('E:/降水-土壤水分和地形推求地灾发生概率/灾害的P和SSM/NEW/urabnandnonurban/urbanHRLT.txt', urbanauc_scores_a1, fmt="%f") 
np.savetxt('E:/降水-土壤水分和地形推求地灾发生概率/灾害的P和SSM/NEW/urabnandnonurban/urbanMSWEP.txt', urbanauc_scores_a2, fmt="%f") 
np.savetxt('E:/降水-土壤水分和地形推求地灾发生概率/灾害的P和SSM/NEW/urabnandnonurban/urbanCHIRPS.txt', urbanauc_scores_a3, fmt="%f") 
np.savetxt('E:/降水-土壤水分和地形推求地灾发生概率/灾害的P和SSM/NEW/urabnandnonurban/urbanGPM.txt', urbanauc_scores_a4, fmt="%f")



# 删除包含NaN值的行
df5= df[~np.any(nan_indices, axis=1)]
df6 =df5[df5['LUC'] != 8]


#非城市区域
m=0
t=2500

o_target = df6['occur'][m:t]
Terr=df6.iloc[m:t, 4:10]
HRLT=df6.iloc[m:t, 11:15]
MSWEP=df6.iloc[m:t, 15:19]
GPM=df6.iloc[m:t, 19:23]
CHIRPS=df6.iloc[m:t, 23:27]

SM=df6.iloc[m:t, 27:33]
RW=df6.iloc[m:t, 35:37]
# #目前来说 累积72小时降水和表层土壤水分更适合建模

# 创建一个空列表来存储每次计算的AUC值
nonurbanauc_scores1 = []
nonurbanauc_scores2 = []
nonurbanauc_scores3 = []
nonurbanauc_scores4 = []

for _ in range(20):
    nonurbantemp_scores1 = [] 
    nonurbantemp_scores2 = []
    nonurbantemp_scores3 = [] 
    nonurbantemp_scores4 = []
    for i in range(4):
        for j in range(4): 
            factors = pd.concat([HRLT.iloc[:, i], SM.iloc[:, j],Terr,RW], axis=1)
# 标准化处理
            scaler = StandardScaler()
            factors_scaled = scaler.fit_transform(factors)
# Randomly select 70% of the data for training
            X_train, X_test, y_train, y_test = train_test_split(factors_scaled, o_target, test_size=0.20, random_state=42)
# Train your model using the training set
            rf = RandomForestRegressor(n_estimators=1000, criterion='squared_error', max_features='log2', bootstrap=True, n_jobs=-1, oob_score=True)
            rf.fit(X_train, y_train)
            importancesrf = rf.feature_importances_
# Predict the remaining 30% of the data
            yrf_pred = rf.predict(X_test)
# Calculate the AUC
            rfauc1 = roc_auc_score(y_test, yrf_pred)  
            print(rfauc1)
            nonurbantemp_scores1.append(rfauc1)
             
            factors = pd.concat([MSWEP.iloc[:, i], SM.iloc[:, j],Terr,RW], axis=1)
# 标准化处理
            scaler = StandardScaler()
            factors_scaled = scaler.fit_transform(factors)
# Randomly select 70% of the data for training
            X_train, X_test, y_train, y_test = train_test_split(factors_scaled, o_target, test_size=0.20, random_state=42)
# Train your model using the training set
            rf = RandomForestRegressor(n_estimators=1000, criterion='squared_error', max_features='log2', bootstrap=True, n_jobs=-1, oob_score=True)
            rf.fit(X_train, y_train)
            importancesrf = rf.feature_importances_
# Predict the remaining 30% of the data
            yrf_pred = rf.predict(X_test)
# Calculate the AUC
            rfauc2 = roc_auc_score(y_test, yrf_pred)   
            nonurbantemp_scores2.append(rfauc2)
            
        
            factors = pd.concat([CHIRPS.iloc[:, i], SM.iloc[:, j],Terr,RW], axis=1)
# 标准化处理
            scaler = StandardScaler()
            factors_scaled = scaler.fit_transform(factors)
# Randomly select 70% of the data for training
            X_train, X_test, y_train, y_test = train_test_split(factors_scaled, o_target, test_size=0.20, random_state=42)
# Train your model using the training set
            rf = RandomForestRegressor(n_estimators=1000, criterion='squared_error', max_features='log2', bootstrap=True, n_jobs=-1, oob_score=True)
            rf.fit(X_train, y_train)
            importancesrf = rf.feature_importances_
# Predict the remaining 30% of the data
            yrf_pred = rf.predict(X_test)
# Calculate the AUC
            rfauc3 = roc_auc_score(y_test, yrf_pred)   
            nonurbantemp_scores3.append(rfauc3) 
            
            
            
            factors = pd.concat([GPM.iloc[:, i], SM.iloc[:, j],Terr,RW], axis=1)
# 标准化处理
            scaler = StandardScaler()
            factors_scaled = scaler.fit_transform(factors)
# Randomly select 70% of the data for training
            X_train, X_test, y_train, y_test = train_test_split(factors_scaled, o_target, test_size=0.20, random_state=42)
# Train your model using the training set
            rf = RandomForestRegressor(n_estimators=1000, criterion='squared_error', max_features='log2', bootstrap=True, n_jobs=-1, oob_score=True)
            rf.fit(X_train, y_train)
            importancesrf = rf.feature_importances_
# Predict the remaining 30% of the data
            yrf_pred = rf.predict(X_test)
# Calculate the AUC
            rfauc4 = roc_auc_score(y_test, yrf_pred)   
            nonurbantemp_scores4.append(rfauc4) 
            
            
    # 将AUC值添加到列表中
    nonurbanauc_scores1.append(nonurbantemp_scores1)
    nonurbanauc_scores2.append(nonurbantemp_scores2)
    nonurbanauc_scores3.append(nonurbantemp_scores3)
    nonurbanauc_scores4.append(nonurbantemp_scores4)


nonurbanauc_scores_a1 = np.array(nonurbanauc_scores1)
nonurbanauc_scores_a2 = np.array(nonurbanauc_scores2)
nonurbanauc_scores_a3 = np.array(nonurbanauc_scores3)
nonurbanauc_scores_a4 = np.array(nonurbanauc_scores4)


np.savetxt('E:/降水-土壤水分和地形推求地灾发生概率/灾害的P和SSM/NEW/urabnandnonurban/nonurbanHRLT.txt', nonurbanauc_scores_a1, fmt="%f") 
np.savetxt('E:/降水-土壤水分和地形推求地灾发生概率/灾害的P和SSM/NEW/urabnandnonurban/nonurbanMSWEP.txt', nonurbanauc_scores_a2, fmt="%f") 
np.savetxt('E:/降水-土壤水分和地形推求地灾发生概率/灾害的P和SSM/NEW/urabnandnonurban/nonurbanCHIRPS.txt', nonurbanauc_scores_a3, fmt="%f") 
np.savetxt('E:/降水-土壤水分和地形推求地灾发生概率/灾害的P和SSM/NEW/urabnandnonurban/nonurbanGPM.txt', nonurbanauc_scores_a4, fmt="%f")


print('OK')


# #xgboo = xgb.XGBRegressor(
#     max_depth=6,
#     learning_rate=0.1,
#     n_estimators=800,
#     subsample=1,
#     colsample_bytree=1,
#     reg_alpha=0,
#     reg_lambda=1,
#     objective='reg:squarederror'
# )
# #xgboo  = xgb.XGBClassifier()
# xgboo.fit(X_train, y_train)
# # 创建一个解释器对象
# explainer = shap.Explainer(xgboo)

# # 计算特征重要性
# shap_values = explainer(X_train)
# # 绘制SHAP摘要图
# shap.summary_plot(shap_values, X_train, plot_type='bar')

# yxgb_pred = xgboo.predict(X_test)

# # Calculate the AUC
# rfauc = roc_auc_score(y_test, yxgb_pred)

# print("xgbAUC:", rfauc)

# Sort the importances in descending order
#sorted_indices = np.argsort(importancesrf)[::-1]
#sorted_importances = importancesrf[sorted_indices]

# Create labels for the x-axis
#labels = np.arange(1, len(importancesrf) + 1)
#feature_names = ['ela','pre1d', 'pre2d', 'pre3d', 'pre7d','elevation','slope','aspect','TPI','GRACE','SM_10','SM_20','SM_30']

# plt.figure(1)

# feature_names = ['pre','sm','elevation','slope','aspect','TPI','topodiversity','cprof','cplan','GRACE']

# labels = [f' {feature_names[i]}' for i in range(len(importancesrf))]


# # Plot the feature importances
# plt.bar(labels, importancesrf)

# # Add labels and title
# plt.xlabel('Feature')
# plt.ylabel('Importance')
# plt.title('Feature Importances')

# # Adjust the x-axis tick labels
# plt.xticks(labels)


# plt.figure(2)

# #feature_names = ['pre1d','elevation','slope','aspect','TPI','GRACE','SM_10','SM_20','SM_30']

# labels = [f' {feature_names[i]}' for i in range(len(importancesrf))]


# # Plot the feature importances
# plt.bar(labels, importanceLR)

# # Add labels and title
# plt.xlabel('Feature')
# plt.ylabel('Importance')
# plt.title('Feature Importances')

# # Adjust the x-axis tick labels
# plt.xticks(labels)

plt.figure(1)
y_rf_prob = rf.predict(X_test)

fpr_rf, tpr_rf, _ = roc_curve(y_test, y_rf_prob)


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





   




 


