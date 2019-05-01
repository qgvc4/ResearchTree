import ReactDOM from 'react-dom';
import React from 'react';

import {Provider} from 'react-redux';
import {BrowserRouter,Route,Switch,Redirect} from 'react-router-dom';

import LoginForm from './components/Account/Login';
import Signup from './components/Account/Signup';
import FeedWithLayout from './components/Feed/FeedWithLayout';
import PeopleWithLayout from './components/People/PeopleWithLayout';
import ProfileWithLayout from './components/Profile/ProfileWithLayout';
import JobWithLayout from './components/Job/JobWithLayout';

import store from './store';

import './style/index.css';

ReactDOM.render(
    (<Provider store={store}>
        <BrowserRouter>
            <div>
                <Switch>
                    <Route exact path='/Login' component={LoginForm}></Route>
                    <Route path='/Feed' component={FeedWithLayout}></Route>
                    <Route path='/People' component={PeopleWithLayout}></Route>
                    <Route path='/Signup' component={Signup}></Route>
                    <Route path='/Job' component={JobWithLayout}></Route>                
                    <Route path='/Profile' component={ProfileWithLayout}></Route>  
                    <Redirect to='/Feed'></Redirect>
                </Switch>
            </div>
        </BrowserRouter>
        </Provider>),        
    document.getElementById('root')
)

