import React, { Component } from 'react'
import {Redirect} from 'react-router-dom'
import {connect} from 'react-redux'

import { Layout } from 'antd';

import PeopleList from './PeopleList'

import NavbarPeople from './Navbar';

const {
    Content, Sider, Header,
  } = Layout;

class People extends Component {
    render() {
        return (
            <div>
                {
                    this.props.user.token ? 
                    renderPeople(): 
                    <Redirect to='/Login' />
                }
            </div>
        )
    }
}

function renderPeople() {
    return(
        //try layout
        <div>
            <Layout>
            <Header style={{background:'#c1e791', position: 'fixed', zIndex: 1, width: '100%' }}><h1 style={{color:'white'}}>ResearchTree</h1></Header>
                <Layout>
                    <Sider style={{marginTop: '5%'}}>
                        <NavbarPeople />
                    </Sider>
                    <Content style={{marginTop: '6%'}}>
                        <PeopleList />
                    </Content>
                </Layout>
            </Layout>
        </div>
    );
}

const mapStateToProps = state => ({
    user: state.user.user
})

export default connect(mapStateToProps, {})(People);