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

df = pd.read_excel('E:/降水-土壤水分和地形推求地灾发生概率/灾害的P和SSM/NEW/CHINANEW.xlsx', sheet_name='ALL')
#df = pd.read_excel('E:/降水-土壤水分和地形推求地灾发生概率/灾害的P和SSM/GBA.xlsx', sheet_name='Sheet3')
# 提取经纬度和日期列
#factors = df.iloc[:, 1:10]

# 查找包含NaN值的索引
nan_indices = np.isnan(df)

# 删除包含NaN值的行
df1= df[~np.any(nan_indices, axis=1)]
df2 = df1[df1['LUC'] == 8]

# o_target = df1['occur']
# Terr=df1.iloc[:, 0:7]
# rain=df1.iloc[:, 7:11]
# SM=df1.iloc[:, 11:15]
# land=df1['CLCD2007']
# factors = pd.concat([rain.iloc[:, 2], SM.iloc[:, 0], Terr,land], axis=1)
#所有区域
#m=900
#t=6726

m=900
t=6726
#城市区域
#m=100
#t=600

#非城市区域
#m=0
#t=2500

o_target = df1['occur'][m:t]
Terr=df1.iloc[m:t, 4:10]
HRLT=df1.iloc[m:t, 11:15]
MSWEP=df1.iloc[m:t, 15:19]
CHIRPS=df1.iloc[m:t, 19:23]
SM=df1.iloc[m:t, 23:27]
RW=df1.iloc[m:t, 29:31]
# #目前来说 累积72小时降水和表层土壤水分更适合建模

# 创建一个空列表来存储每次计算的AUC值
auc_scores1 = []
auc_scores2 = []
auc_scores3 = []

for _ in range(50):
    temp_scores1 = [] 
    temp_scores2 = []
    temp_scores3 = [] 
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
            print(i)
        
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
            
    # 将AUC值添加到列表中
    auc_scores1.append(temp_scores1)
    auc_scores2.append(temp_scores2)
    auc_scores3.append(temp_scores3)


auc_scores_a1 = np.array(auc_scores1)
auc_scores_a2 = np.array(auc_scores2)
auc_scores_a3 = np.array(auc_scores3)

average_auc1 = np.mean(auc_scores1)    
average_auc2 = np.mean(auc_scores2)
average_auc3 = np.mean(auc_scores3)
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

#y_xgb_prob = xgboo.predict(X_test)
# Compute the false positive rate (FPR) and true positive rate (TPR) for ROC curve
fpr_rf, tpr_rf, _ = roc_curve(y_test, y_rf_prob)

#fpr_xgb, tpr_xgb, _ = roc_curve(y_test, y_xgb_prob)

# Compute the area under the ROC curve (AUC)
auc_rf = auc(fpr_rf, tpr_rf)

#auc_xgb = auc(fpr_xgb, tpr_xgb)


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
#plt.show()




#print(importances)#调取关于特征重要程度
#print("%.3f"%rf.oob_score_)

# outname1=r'G:\2023codes\Codes\Importance\o_targetrf.txt'
# np.savetxt(outname1, o_targetrf, fmt="%10.3f")

# outname1=r'G:\2023codes\Codes\Importance\importancesrf.txt'
# np.savetxt(outname1, importancesrf, fmt="%10.3f")




   




 


