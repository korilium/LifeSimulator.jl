using Dates
using LifeSimulator

include("../src/LifeSimulator.jl")

using LifeSimulator

# Select the model you want to use, with parameters you like.
# Read the documentation with `?LifelibBasiclife` (help mode) in the REPL.
model = LifelibBasiclife(inflation_rate = 0.03)


model.mortality
model.acquisition_cost

model.lapse
model.load_premium_rate


policies = [
    PolicySet(Policy(term = Year(20), age = Year(20), premium = 200_000), 100),
    PolicySet(Policy(term = Year(20), age = Year(45), premium = 600_000), 80),
    PolicySet(Policy(term = Year(10), age = Year(70), premium = 400_000), 50),
]

n= 100

simulate(model, policies, n) do events 
    cf = CashFlow(events, model)
    display(cf)
end ;

test = TabularMortality()


test.rates[1,1]



estimate_premiums(model, policies,n)