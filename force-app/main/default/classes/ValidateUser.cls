public class ValidateUser {
    
    @InvocableMethod(
        label='Generate One Time Password'
        description='Generate and email a one time password for a specific user'
    )
    public static List<Boolean> generateOTP(List<String> userIds) {
        
        List<Boolean> response = new List<Boolean>();
        Boolean result = false;
        String userId = userIds[0];
        
        if(String.isNotBlank(userId)) {
            Integer otp = Math.round(Math.random() * (999999 - 100000)) + 100000;
            
            User u = [Select Id,Email from User where Id = :userId];
            u.OTP__c = String.valueOf(otp); 
            update u;    
            
            Map<String, Object> params = new Map<String, Object>();
            params.put('toAddress',u.Email);
            params.put('otpToSend',String.valueOf(otp));

            Flow.Interview.Send_Email_Flow emailFlow = new Flow.Interview.Send_Email_Flow(params);

            emailFlow.start();
            
            result = true;            
        }
        
        response.add(result);
        return response;
    }
    
}