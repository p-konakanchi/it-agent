public without sharing class UserPasswordReset {
    
    @InvocableMethod(
        label='Reset User Password'
        description='Send password reset email for a specific user'
    )
    public static List<Boolean> resetPassword(List<String> userIds) {
        
        List<Boolean> response = new List<Boolean>();
        Boolean result = false;
        String userId = userIds[0];
        
        if(String.isNotBlank(userId)) {
            System.ResetPasswordResult reset = System.resetPassword(userId,true);
            if(reset != null) {
                result = true;                
            }
        }
        
        response.add(result);
        return response;
    }
    
}