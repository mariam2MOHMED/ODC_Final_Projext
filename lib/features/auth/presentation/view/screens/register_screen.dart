import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_icons/icon_icons.dart';
import 'package:odcorange/core/constants/App_Colors.dart';
import 'package:odcorange/core/constants/styles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:odcorange/core/widets/custom_btn.dart';
import 'package:odcorange/features/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:odcorange/features/auth/presentation/view/screens/login_screen.dart';
import 'package:odcorange/features/auth/presentation/view/widgets/label_text_input.dart';
import 'package:odcorange/features/home/presentation/screens/home_page.dart';
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var fromkey=GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthRegisterSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Success Register"),

            ));
            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                HomePage()));
          }if (state is AuthRegisterFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
            print("the error is${state.message}");
          }
        },
        builder: (context, state) {
return   Scaffold(
  resizeToAvoidBottomInset: false,
  body: ConditionalBuilder(condition: state is !AuthRegisterLoading,
    builder:(context)=> Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w),
      child: Form(key: fromkey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.h,),
            Text("Create your new\n account.",style: Styles.style32,),
            SizedBox(height: 24.h,),
            LabelTxtInput(label: "User Name", hint: "User Name", controller: userNameController,
                validator: (value){
                  if(value!.isEmpty||value==null){
                    return "UserName Must be not empty";
                  }else{
                    return null;
                  }
                }),
            SizedBox(height: 16.h,),
            LabelTxtInput(label: "Email", hint: "Email",
                controller: emailController,
                validator: (value){
                  if(value!.isEmpty||value==null){
                    return "Email Must be not empty";
                  }else{
                    return null;
                  }
                }),
            SizedBox(height: 16.h,),
            LabelTxtInput(
                isPassword: true,
                label: "Password", hint: "Password",
                controller: passwordController,
                validator: (value){
                  if(value!.isEmpty||value==null){
                    return "Password Must be not empty";
                  }else{
                    return null;
                  }
                }),
            SizedBox(height: 24.h,),
            CustomBtn(onPressed: (){
              if(fromkey.currentState!.validate()){
                context.read<AuthCubit>().register(
                    emailController.text,
                    userNameController.text,

                    passwordController.text);

              }
            }, txt: "Register"),
            SizedBox(height: 20.h,),
            SizedBox(height: 16),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 20.w,vertical: 16.h
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(34),
                    border: Border.all(
                      width: 1.0,color: Color(0xFF292A2E),
                    )
                ),
                child: Center(child:
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/Google.png",fit: BoxFit.cover,height: 27.h,),
                    Text("   Continue with google",style: Styles.style16white.copyWith(
                      color: Color(0xFF292A2E),fontWeight: FontWeight.w400,
                    ),),
                  ],
                ))
            ),
            SizedBox(height: 16.h),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 20.w,vertical: 16.h
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(34),
                    border: Border.all(
                      width: 1.0,color: Color(0xFF292A2E),
                    )
                ),
                child: Center(child:
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconIcons.facebook(
                        height: 32.h,width: 32.w
                    ),
                    Text("  Continue with google",style: Styles.style16white.copyWith(
                      color: Color(0xFF292A2E),fontWeight: FontWeight.w400,
                    ),),
                  ],
                ))
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Text("Already have an account.",
                  style: Styles.style16grey,),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      LoginScreen()));
                },
                  child:   Text("Login",style: Styles.style16blue,),)
              ],
            )
          ],
        ),
      ),
    ),
      fallback: (context)=>Center(child:
      LoadingAnimationWidget.threeArchedCircle(color: AppColors.primary,
          size: 40.sp))
  ),

);
          

        },
      ),
    );
  }
}
