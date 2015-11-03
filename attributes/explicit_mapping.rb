default[:openidm][:explicit_mapping] =
'
{ "link" : {
      "table" : "links",
      "objectToColumn" : {
          "_id" : "objectid",
          "_rev" : "rev",
          "linkType" : "linktype",
          "firstId" : "firstid",
          "secondId" : "secondid"
      }
  },
  "ui/notification" : {
      "table" : "uinotification",
      "objectToColumn" : {
          "_id" : "objectid",
          "_rev" : "rev",
          "requester" : "requester",
          "requesterId" : "requesterId",
          "receiverId" : "receiverId",
          "createDate" : "createDate",
          "notificationType" : "notificationType",
          "notificationSubtype" : "notificationSubtype",
          "message" : "message"
      }
  },
  "internal/user" : {
      "table" : "internaluser",
      "objectToColumn" : {
          "_id" : "objectid",
          "_rev" : "rev",
          "password" : "pwd",
          "roles" : "roles"
      }
  },
  "audit/activity" : {
      "table" : "auditactivity",
      "objectToColumn" : {
          "_id" : "objectid",
          "activityId" : "activityid",
          "timestamp" : "activitydate",
          "action" : "activity",
          "message" : "message",
          "objectId" : "subjectid",
          "rev" : "subjectrev",
          "rootActionId" : "rootactionid",
          "parentActionId" : "parentactionid",
          "requester" : "requester",
          "approver" : "approver",
          "before" : "subjectbefore",
          "after" : "subjectafter",
          "status" : "status",
          "changedFields" : "changedfields",
          "passwordChanged" : "passwordchanged"
      }
  },
  "audit/recon" : {
      "table" : "auditrecon",
      "objectToColumn" : {
          "_id" : "objectid",
          "entryType" : "entrytype",
          "rootActionId" : "rootactionid",
          "action" : "activity",
          "message" : "message",
          "reconciling" : "reconciling",
          "reconId" : "reconid",
          "reconAction" : "reconaction",
          "situation" : "situation",
          "sourceObjectId" : "sourceobjectid",
          "status" : "status",
          "targetObjectId" : "targetobjectid",
          "ambiguousTargetObjectIds" : "ambiguoustargetobjectids",
          "timestamp" : "activitydate",
          "actionId" : "actionid",
          "exception" : "exceptiondetail",
          "mapping" : "mapping",
          "messageDetail" : {
              "column" : "messagedetail",
              "type" : "JSON_MAP"
          }
      }
  },
  "audit/sync" : {
      "table" : "auditsync",
      "objectToColumn" : {
          "_id" : "objectid",
          "status" : "status",
          "situation" : "situation",
          "action" : "activity",
          "actionId" : "actionid",
          "rootActionId" : "rootactionid",
          "sourceObjectId" : "sourceobjectid",
          "targetObjectId" : "targetobjectid",
          "timestamp" : "activitydate",
          "mapping" : "mapping",
          "exception" : "exceptiondetail",
          "message" : "message",
          "messageDetail" : {
              "column" : "messagedetail",
              "type" : "JSON_MAP"
          }
      }
  },
  "audit/access" : {
      "table" : "auditaccess",
      "objectToColumn" : {
          "_id" : "objectid",
          "action" : "activity",
          "ip" : "ip",
          "principal" : "principal",
          "roles" : "roles",
          "status" : "status",
          "timestamp" : "activitydate"
      }
  },
  "security" : {
      "table" : "security",
      "objectToColumn" : {
          "_id" : "objectid",
          "_rev" : "rev",
          "storeString" : "storestring"
      }
  },
  "security/keys" : {
      "table" : "securitykeys",
      "objectToColumn" : {
          "_id" : "objectid",
          "_rev" : "rev",
          "keyPair" : "keypair"
      }
  }
}
'
