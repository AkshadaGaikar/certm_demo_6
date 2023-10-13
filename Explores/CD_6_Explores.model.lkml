connection: "@{CONNECTION_NAME}"

include: "/Views/*.view.lkml"              # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project

#include: "/Dashboards/*.dashboard.lookml"   # include a LookML dashboard called my_dashboard

explore: cd_6_View {}
