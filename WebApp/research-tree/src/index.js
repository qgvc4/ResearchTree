import ReactDOM from 'react-dom';
import React from 'react';

import {Provider} from 'react-redux';
import {BrowserRouter,Route,Switch,Redirect} from 'react-router-dom';

import LoginForm from './components/Account/Login';
import Feed from './components/Feed/Feed';
import Signup from './components/Account/Signup';
import People from './components/People/People';
import Profile from './components/Profile/Profile';

import store from './store';

import './style/index.css';

ReactDOM.render(
    (<Provider store={store}>
        <BrowserRouter>
            <div>
                <Switch>
                    <Route exact path='/Login' component={LoginForm}></Route>
                    <Route path='/Feed' component={Feed}></Route>
                    <Route path='/People' component={People}></Route>
                    <Route path='/Signup' component={Signup}></Route>                  
                    <Route path='/Profile' component={Profile}></Route>  
                    <Redirect to='/Feed'></Redirect>
                </Switch>
            </div>
        </BrowserRouter>
        </Provider>),        
    document.getElementById('root')
)

