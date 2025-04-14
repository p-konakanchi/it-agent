public without sharing class ValidateUser {
    
    @InvocableMethod(
        label='Generate One Time Password'
        description='Generate and email a one time password for a specific user'
    )
    public static List<Boolean> generateOTP(List<String> userIds) {
        
        List<Boolean> response = new List<Boolean>();
        Boolean result = false;
        String userId = userIds[0];
        
        try {
            if(String.isNotBlank(userId)) {
                Integer otp = Math.round(Math.random() * (999999 - 100000)) + 100000;
                
                User u = [Select Id,Email from User where Id = :userId WITH SYSTEM_MODE];
                u.OTP__c = String.valueOf(otp); 
                Database.update(u,AccessLevel.SYSTEM_MODE);    
                
                Map<String, Object> params = new Map<String, Object>();
                params.put('toAddress',u.Email);
                params.put('otpToSend',String.valueOf(otp));
                
                system.debug(params);
                Flow.Interview.Send_Email_Flow emailFlow = new Flow.Interview.Send_Email_Flow(params);                
                
                emailFlow.start();  
                result = true;  
            }
        }
        
        catch (Exception ex) {
            system.debug(ex.getStackTraceString());            
            result = false;  
        }
        
        response.add(result);
        return response;
    }
    
}