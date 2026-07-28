import pandas as pd

df = pd.read_csv('predictive_maintenance.csv')


production_df = df[[
    'UDI', 
    'Product ID', 
    'Type', 
    'Air temperature [K]', 
    'Process temperature [K]', 
    'Rotational speed [rpm]', 
    'Torque [Nm]'
]]


quality_df = df[[
    'Product ID', 
    'Tool wear [min]', 
    'Target'
]]


maintenance_df = df[[
    'Product ID', 
    'Failure Type'
]]


production_df.to_csv('Production.csv', index=False)
quality_df.to_csv('Quality.csv', index=False)
maintenance_df.to_csv('Maintenance.csv', index=False)

print("Successfully created Production.csv, Quality.csv, and Maintenance.csv!")
