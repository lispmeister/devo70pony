actor Main
  let _env: Env
  
  new create(env: Env) =>
    _env = env
    let hello = Hello(_env, "Hello World!")

    
actor Hello
  let _env: Env
  
  new create(env: Env, message: String)
  =>
    _env = env
    let greeter = Greeter(env, this)
    _env.out.print("Calling greeter...")
    greeter.print(message)

  be cancel()
  =>
    _env.out.print("Received cancel. Shutting down...")
    
    
actor Greeter 
  let _env: Env
  let _supervisor: Hello
  
  new create(env: Env, supervisor: Hello)
  =>
    _env = env
    _supervisor = supervisor

  be print(message: String)
  =>
    _env.out.print("\tReceived a message: " + message)
    _supervisor.cancel()
